import 'package:flutter/material.dart';
import 'package:helppyapp/controllers/controllerTabHome.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/tabhome/view_list.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CardIdoso extends StatelessWidget {
    final AsyncSnapshot snapshot;
    final ControllerTabHome controllerHome;
    final int index;
    CardIdoso({@required this.controllerHome, @required this.snapshot, @required this.index});

    String statusRequest(AsyncSnapshot snapshot, int index){
        switch(snapshot.data[index]["status"]){
            case "1":
                return "Aceito por: " + snapshot.data[index]["accept_by"];
                break;
            case "2":
                return "Seu pedido foi aceito e finalizado por: " + snapshot.data[index]["accept_by"];
                break;
            default:
                return "Seu pedido ainda não foi aceito..";
        }
    }

    List transformStringInList(AsyncSnapshot snapshot, int index) {
        String buildText = '';
        List list = [];
        var response = snapshot.data[index];

        String replaceString = response['shoppings']
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "");

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

    String replaceDate(AsyncSnapshot snapshot, int index) {
        String buildText = '';
        List list = [];
        var responseString = snapshot.data[index]["created_at"].substring(0, 10);

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

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        return Container(
            width: _width,
            margin: index == (snapshot.data.length - 1) ? EdgeInsets.only(top: 15.0, bottom: 75.0) : EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
                color: snapshot.data[index]["status"] == "2" ? Color.fromRGBO(8, 77, 110, 1.0) : COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
                children: <Widget>[
                    Container(
                        width: _width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                            snapshot.data[index]["status"] == "2" ? snapshot.data[index]["title"] + "(Finalizado)" : snapshot.data[index]["title"]  + "(Em andamento)",
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Descrição: " + snapshot.data[index]["description"],
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0, bottom: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            statusRequest(snapshot, index),
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Pedido feito em " + replaceDate(snapshot, index),
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: OutlineButton(
                                        onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                    return ViewList(transformStringInList(snapshot, index));
                                                },
                                            ));
                                        },
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            "Ver lista".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ),
                                snapshot.data[index]["status"] == "0" || snapshot.data[index]["status"] == "2" ? SizedBox(
                                    width: 10.0,
                                ) : Container(),
                                snapshot.data[index]["status"] == "0" || snapshot.data[index]["status"] == "2" ? Expanded(
                                    child: OutlineButton(
                                        onPressed: (){
                                            Widget cancel = FlatButton(
                                                child: Text("Cancelar"),
                                                onPressed: () {
                                                    Navigator.of(context).pop();
                                                },
                                            );

                                            Widget delete = FlatButton(
                                                child: Text("Sim"),
                                                onPressed: () async {
                                                    http.Response data = await http.delete(
                                                        API_URL + '/list/' + snapshot.data[index]["id"].toString(),
                                                        headers: {
                                                            "Content-Type": "application/json; charset=utf-8",
                                                            HttpHeaders.authorizationHeader: "Bearer " + controllerHome.prefs.getString('token')
                                                        },
                                                    );

                                                    if(data.statusCode == 200){
                                                        controllerHome.getResult();
                                                        Navigator.pop(context);

                                                    } else {
                                                        Navigator.of(context).pop();
                                                        showAlertDialog(context, "Ocorreu um erro :(", "Algo deu errado, não foi possível cancelar seu pedido neste momento, tente novamente mais tarde.");
                                                    }
                                                },
                                            );
                                            AlertDialog alerta = AlertDialog(
                                                title: Text(snapshot.data[index]["status"] == "2" ? "Você está prestes a apagar este pedido do seu histórico!" : "Você está prestes a cancelar este pedido!"),
                                                content: Text("Essa ação não pode ser desfita, tem certeza?"),
                                                actions: [
                                                    cancel,
                                                    delete,
                                                ],
                                            );
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                    return alerta;
                                                },
                                            );
                                        },
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            snapshot.data[index]["status"] == "2" ? "Apagar".toUpperCase() : "Cancelar".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ) : Container()
                            ],
                        ),
                    )
                ],
            ),
        );
    }
}
