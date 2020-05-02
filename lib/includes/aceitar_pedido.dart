import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/ui/control_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptRequest extends StatefulWidget {
    dynamic info;
    AcceptRequest(this.info);

    @override
    _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
    var prefs, infoAccept;
    int onRequest;

    setValue() async {
        prefs = await SharedPreferences.getInstance();
        onRequest = prefs.get('onRequest');
        if(onRequest == 1){
            widget.info = jsonDecode(prefs.getString('infoRequest'));
            widget.info["shoppings"] = toList(widget.info);
        } else {
            widget.info["shoppings"] = toList(widget.info);
        }
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: setValue(),
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    case ConnectionState.active:
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
                                strokeWidth: 5.0,
                            ),
                        );
                    case ConnectionState.done:
                        return _screenRequest();
                        break;
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
                itemCount: widget.info["shoppings"].length,
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
                                        widget.info["title"],
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
                                        "Distância: ",
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
                                        "Descrição: " + widget.info["description"],
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
                                        "Pedido feito em: " + widget.info["created_at"].substring(0, 10).replaceAll("-", "/"),
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
                                        "Pedido feito por: " + widget.info["full_name"],
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
                                        "Contato: " + widget.info["telephone"],
                                        style: TextStyle(
                                            color: COR_AZUL,
                                            fontSize: 16.0
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Divider(),
                                ),
                                _itemList(widget.info["shoppings"][index]),
                            ],
                        );
                    } else if(index == (widget.info["shoppings"].length - 1)){
                        return Column(
                            children: <Widget>[
                                _itemList(widget.info["shoppings"][index]),
                                Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Divider(),
                                ),
                                FlatButton(
                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                                    onPressed: () async {
                                        if(onRequest != 1){
                                            var url = 'https://helppy-19.herokuapp.com/accept/' + prefs.getInt('user_id').toString() + "/" + widget.info["id"].toString();
                                            var response = await http.post(
                                                url,
                                                headers: {"Content-Type": "application/json; charset=utf-8"},
                                                body: jsonEncode(<String, String>{
                                                    "accept_by": "Teste de Teste",
                                                    "accept_by_id": "2",
                                                    "status": "1"
                                                })
                                            );

                                            print(response.statusCode);

                                            prefs.setInt("onRequest", 1);
                                            infoAccept = prefs.setString("infoRequest", jsonEncode(widget.info).toString());

                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                    return AcceptRequest(infoAccept);
                                                },
                                            ));
                                        } else {
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
                                )
                            ],
                        );
                    } else {
                        return _itemList(widget.info["shoppings"][index]);
                    }
                },
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

    toList(data){
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
}
