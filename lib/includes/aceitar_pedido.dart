import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptRequest extends StatefulWidget {
    dynamic info;
    bool newRequest;
    AcceptRequest(this.info, this.newRequest);

    @override
    _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
    var prefs;

    @override
    void initState() {
        super.initState();

        if(widget.newRequest == false){
            widget.info["shoppings"] = toList(widget.info);
        }
    }

    requestData() async {
        prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        final response = await http.get(
            'https://helppy-19.herokuapp.com/list/' + widget.info,
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );

        widget.info = json.decode(response.body);
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: requestData(),
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
            ),
            body: ListView.builder(
                itemCount: widget.info[0]["shoppings"].length,
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
                                        widget.info[0]["title"],
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
                                        "Descrição: " + widget.info[0]["description"],
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
                                        "Pedido feito em: " + widget.info[0]["created_at"].substring(0, 10).replaceAll("-", "/"),
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
                                        "Pedido feito por: " + widget.info[0]["full_name"],
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
                                        "Contato: ",
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
                                _itemList(widget.info[0]["shoppings"][index]),
                            ],
                        );
                    } else if(index == (widget.info[0]["shoppings"].length - 1)){
                        return Column(
                            children: <Widget>[
                                _itemList(widget.info[0]["shoppings"][index]),
                                Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Divider(),
                                ),
                                FlatButton(
                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                                    onPressed: (){
                                        //
                                    },
                                    color: COR_PRETA,
                                    child: Text(
                                        widget.newRequest == true ? "Finalizar pedido".toUpperCase() : "Aceitar pedido".toUpperCase(),
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
                        return _itemList(widget.info[0]["shoppings"][index]);
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
            .replaceAll("{", "")
            .replaceAll("\"", "")
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
