import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';

class AcceptRequest extends StatefulWidget {
    @override
    _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: COR_AZUL,
            ),
            body: ListView.builder(
                itemCount: 10,
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
                                        "Title",
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
                                        "Descrição: ",
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
                                        "Pedido feito em: ",
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
                                        "Pedido feito por: ",
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
                            ],
                        );
                    } else if(index == 9){
                        return Column(
                            children: <Widget>[
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
                                        "Aceitar pedido".toUpperCase(),
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
                                "Fon",
                                style: TextStyle(fontSize: 20, color: COR_BRANCO),
                            ),
                        );
                    }
                },
            ),
        );
    }
}
