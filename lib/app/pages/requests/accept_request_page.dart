import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/components/control/control_page_component.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/export_pages_component.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';

class AcceptRequest extends StatefulWidget {
    final dynamic info;
    AcceptRequest(this.info);

    @override
    _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
    Map prefs;
    var infoAccept, info;

    List toList(data){
        String buildText = '';
        List list = [];
        String replaceString = data['shoppings']
            .toString()
            .replaceAll("[", "")
            .replaceAll("\"", "")
            .replaceAll("]", "")
            .replaceAll("{", "")
            .replaceAll("}", "");

        for (var i = 0; i < replaceString.length; i++) {
            if(replaceString[i] != ',') {
                buildText += replaceString[i];
            }
            if((i == (replaceString.length - 1)) || (replaceString[i] == ',')) {
                list.add(buildText);
                buildText = '';
            }
        }
        return list;
    }

    String replaceDate(data, int index) {
        String buildText = '';
        List list = [];
        var responseString = data.substring(0, 10);
        for (var i = 0; i < responseString.length; i++) {
            if(responseString[i] != '-') {
                buildText += responseString[i];
            }
            if((i == (responseString.length - 1)) || (responseString[i] == '-')) {
                list.add(buildText);
                buildText = '';
            }
        }
        String replaceString =  list[2].toString() + '/' + list[1].toString() + '/' + list[0].toString();
        return replaceString;
    }

    Future<void> setValue(MainTabController controller) async {
        info = widget.info;
        prefs = await controller.getPreferences();

        if(prefs['onRequest'] == 1){
            info = jsonDecode(prefs['infoRequest']);
            info["shoppings"] = toList(widget.info);
        } else {
            info["shoppings"] = toList(widget.info);
        }
    }

    @override
    Widget build(BuildContext context) {
        final controller = Provider.of<MainTabController>(context);
        return FutureBuilder(
            future: setValue(controller),
            builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return loadingCenter();
                } else {
                    return _screenRequest(controller);
                }
            },
        );
    }

    Widget _screenRequest(MainTabController controller){
        return Scaffold(
            appBar: AppBar(
                backgroundColor: COR_AZUL,
                automaticallyImplyLeading: prefs['onRequest'] == 1 ? false : true,
            ),
            body: ListView.builder(
                itemCount: info["shoppings"].length,
                padding: EdgeInsets.all(10.0),
                shrinkWrap: true,
                itemBuilder: (context, index){
                    if(index == 0){
                        return Column(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                        info["title"],
                                        style: TextStyle(
                                            color: COR_AZUL,
                                            fontSize: 18.0
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Descrição: " + info["description"],
                                        style: TextStyle(
                                            color: COR_AZUL,
                                            fontSize: 16.0
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Pedido feito em: " + replaceDate(info["created_at"], index),
                                        style: TextStyle(
                                            color: COR_AZUL,
                                            fontSize: 16.0
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Pedido feito por: " + info["full_name"],
                                        style: TextStyle(
                                            color: COR_AZUL,
                                            fontSize: 16.0
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        prefs['onRequest'] == 1 ? "Endereço: " + info["address"] + " - número: " + info["house_number"] + " - ponto de referência: " + info["reference"] : "Endereço: Aceite o pedido para ver esta informação",
                                        style: TextStyle(
                                            color: COR_AZUL,
                                            fontSize: 16.0
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                        onTap: () => prefs['onRequest'] == 1 ? launch("tel:" + info["telephone"]) : null,
                                        child: RichText(
                                            text: TextSpan(
                                                text: "Contato: ",
                                                style: TextStyle(
                                                    color: COR_AZUL,
                                                    fontSize: 14.0
                                                ),
                                                children: <TextSpan>[
                                                    TextSpan(
                                                        text: prefs['onRequest'] == 1 ? info["telephone"] : "Aceite o pedido para ver esta informação",
                                                        style: TextStyle(
                                                            color: COR_AZUL,
                                                            fontSize: 14.0,
                                                            decoration: prefs['onRequest'] == 1 ? TextDecoration.underline : TextDecoration.none
                                                        ),
                                                    )
                                                ],
                                            ),
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Divider(),
                                ),
                                _itemList(info["shoppings"][index]),
                                info["shoppings"].length == 1 ? Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Divider(),
                                ) : Container(width: 0, height: 0,),
                                info["shoppings"].length == 1 ? _buttonAccept(context, controller) : Container(width: 0, height: 0,)
                            ],
                        );
                    } else if(index == (info["shoppings"].length - 1)){
                        return Column(
                            children: <Widget>[
                                _itemList(info["shoppings"][index]),
                                Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Divider(),
                                ),
                                _buttonAccept(context, controller)
                            ],
                        );
                    } else {
                        return _itemList(info["shoppings"][index]);
                    }
                },
            ),
        );
    }

    Widget _buttonAccept(BuildContext context, MainTabController controller){
        return FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
            onPressed: () async {
                var response;
                isLoading(context, true);
                var url = API_URL + '/update/' + info["user_id"].toString() + "/" + info["id"].toString();
                if(prefs['onRequest'] != 1){
                    response = await http.post(
                        url,
                        headers: {"Content-Type": "application/json; charset=utf-8", HttpHeaders.authorizationHeader: "Bearer " + prefs['token']},
                        body: jsonEncode(<String, String>{
                            "status": "1",
                            "acceptName": prefs['name'],
                            "acceptId": prefs['user_id'].toString(),
                        })
                    );

                    isLoading(context, false);

                    controller.setPreferences('onRequest', 1);
                    controller.setPreferences('infoRequest', jsonEncode(widget.info).toString());

                    Navigator.pop(context, true);
                } else {
                    response = await http.post(
                        url,
                        headers: {"Content-Type": "application/json; charset=utf-8", HttpHeaders.authorizationHeader: "Bearer " + prefs['token']},
                        body: jsonEncode(<String, String>{
                            "status": "2",
                            "acceptName": prefs['name'],
                            "acceptId": prefs['user_id'].toString(),
                        })
                    );

                    isLoading(context, false);
                    controller.setPreferences("onRequest", 0);

                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context){
                            return ControlPage();
                        },
                    ));
                }
            },
            color: COR_PRETA,
            child: Text(
                prefs['onRequest'] == 1 ? "Finalizar pedido".toUpperCase() : "Aceitar pedido".toUpperCase(),
                style: TextStyle(
                    color: COR_BRANCO,
                    fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
            ),
        );
    }

    Widget _itemList(String str){
        return Container(
            height: 45.0,
            decoration: BoxDecoration(
                color: COR_AZUL,
                border: Border.all(
                    color: COR_STROKE,
                    width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: Text(
                str,
                style: TextStyle(fontSize: 20, color: COR_BRANCO),
            ),
        );
    }
}
