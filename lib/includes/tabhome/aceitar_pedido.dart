import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:helppyapp/includes/ui/control_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';

class AcceptRequest extends StatefulWidget {
    final dynamic info;
    AcceptRequest(this.info);

    @override
    _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
    var prefs, infoAccept, info;
    int onRequest;

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

    Future<void> setValue() async {
        info = widget.info;
        prefs = await SharedPreferences.getInstance();
        onRequest = prefs.get('onRequest');
        if(onRequest == 1){
            info = jsonDecode(prefs.getString('infoRequest'));
            info["shoppings"] = toList(widget.info);
        } else {
            info["shoppings"] = toList(widget.info);
        }
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: setValue(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return loadingCenter();
                } else {
                    return _screenRequest();
                }
            },
        );
    }

    Widget _screenRequest(){
        return Scaffold(
            appBar: AppBar(
                backgroundColor: COR_AZUL,
                automaticallyImplyLeading: onRequest == 1 ? false : true,
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
                                        onRequest == 1 ? "Endereço: " + info["address"] + " - número: " + info["house_number"] + " - ponto de referência: " + info["reference"] : "Endereço: Aceite o pedido para ver esta informação",
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
                                        onTap: () => onRequest == 1 ? launch("tel:" + info["telephone"]) : null,
                                        child: RichText(
                                            text: TextSpan(
                                                text: "Contato: ",
                                                style: TextStyle(
                                                    color: COR_AZUL,
                                                    fontSize: 16.0
                                                ),
                                                children: <TextSpan>[
                                                    TextSpan(
                                                        text: onRequest == 1 ? info["telephone"] : "Contato: Aceite o pedido para ver esta informação",
                                                        style: TextStyle(
                                                            color: COR_AZUL,
                                                            fontSize: 16.0,
                                                            decoration: onRequest == 1 ? TextDecoration.underline : TextDecoration.none
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
                                info["shoppings"].length == 1 ? _buttonAccept(context) : Container(width: 0, height: 0,)
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
                                _buttonAccept(context)
                            ],
                        );
                    } else {
                        return _itemList(info["shoppings"][index]);
                    }
                },
            ),
        );
    }

    Widget _buttonAccept(context){
        return FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
            onPressed: () async {
                isLoading(context, true);
                var response;
                var url = API_URL + '/update/' + info["user_id"].toString() + "/" + info["id"].toString();
                if(onRequest != 1){
                    response = await http.post(
                        url,
                        headers: {"Content-Type": "application/json; charset=utf-8", HttpHeaders.authorizationHeader: "Bearer " + prefs.getString("token")},
                        body: jsonEncode(<String, String>{
                            "status": "1",
                            "acceptName": prefs.getString("name"),
                            "acceptId": prefs.getInt("user_id").toString(),
                        })
                    );

                    print(response.body);

                    isLoading(context, false);

                    prefs.setInt("onRequest", 1);
                    infoAccept = prefs.setString("infoRequest", jsonEncode(widget.info).toString());

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                            return AcceptRequest(infoAccept);
                        },
                    ));
                } else {
                    response = await http.post(
                        url,
                        headers: {"Content-Type": "application/json; charset=utf-8", HttpHeaders.authorizationHeader: "Bearer " + prefs.getString("token")},
                        body: jsonEncode(<String, String>{
                            "status": "2",
                            "acceptName": prefs.getString("name"),
                            "acceptId": prefs.getInt("user_id").toString(),
                        })
                    );

                    print(response.body);

                    isLoading(context, false);
                    prefs.setInt("onRequest", 0);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                            return ControlPage(true);
                        },
                    ));
                }
            },
            color: COR_PRETA,
            child: Text(
                onRequest == 1 ? "Finalizar pedido".toUpperCase() : "Aceitar pedido".toUpperCase(),
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
