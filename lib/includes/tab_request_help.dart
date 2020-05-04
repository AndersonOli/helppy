import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';
import 'package:helppyapp/ui/control_page.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestHelp extends StatefulWidget {
    @override
    _RequestHelpState createState() => _RequestHelpState();
}

class _RequestHelpState extends State<RequestHelp> {
    final shoppingListController = TextEditingController();
    final titleListController = TextEditingController();
    final descriptionController = TextEditingController();
    var prefs;

    bool _userEdited = false;
    List _list = [];

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        return WillPopScope(
            onWillPop: _requestPop,
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: COR_AZUL,
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                        prefs = await SharedPreferences.getInstance();
                        int resul = await _postRequest().then((http.Response response) {
                            return response.statusCode;
                        });

                        if(resul == 200){
                            alertCard(context, "Pedido realizado com sucesso!", "Seu pedido foi registrado, aguarde até que alguém aceite :)");
                        } else {
                            alertCard(context, "Há algo de errado!", "Há um problema a ser resolvido, aguarde e tente novamente mais tarde..");
                        }
                    },
                    child: Icon(
                        Icons.check,
                        color: COR_BRANCO,
                    ),
                    backgroundColor: COR_PRETA,
                ),
                body: SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        children: <Widget>[
                            Container(
                                width: _width,
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: titleListController,
                                    decoration: InputDecoration(
                                        labelText: "Título",
                                        hintText: "Título do pedido",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: COR_AZUL, width: 1.0),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    onChanged: (change) {
                                        _userEdited = true;
                                    },
                                ),
                            ),
                            Container(
                                width: _width,
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: TextField(
                                    controller: descriptionController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        labelText: "Descrição",
                                        hintText: "Descrição do pedido",
                                        border: OutlineInputBorder(),
                                    ),
                                    onChanged: (change) {
                                        _userEdited = true;
                                    },
                                ),
                            ),
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: TextField(
                                            controller: shoppingListController,
                                            onSubmitted: (e){
                                                _addShopping();
                                            },
                                            decoration: InputDecoration(
                                                labelText: "Qual produto deseja?",
                                                hintText: "Nome do produto :)",
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                const EdgeInsets.symmetric(horizontal: 10),
                                            ),
                                            onChanged: (change) {
                                                _userEdited = true;
                                            },
                                        ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: RaisedButton(
                                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            onPressed: _addShopping,
                                            color: COR_PRETA,
                                            child: Icon(
                                                Icons.add,
                                                color: COR_BRANCO,
                                            ),
                                        ),
                                    )
                                ],
                            ),
                            SizedBox(
                                height: 50.0,
                                width: _width - 50.0,
                                child: Divider(color: COR_STROKE),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: _list.length,
                                itemBuilder: (context, index) {
                                    return buildItem(context, index);
                                },
                            )
                        ],
                    ),
                ),
            ));
    }

    Widget buildItem(context, index) {
        return Dismissible(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                        color: COR_STROKE,
                        width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                ),
                child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(
                        Icons.delete,
                        color: COR_BRANCO,
                    ),
                ),
            ),
            child: Container(
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
                    capitalize(_list[index]),
                    style: TextStyle(fontSize: 20, color: COR_BRANCO),
                ),
            ),
            onDismissed: (direction) {
                setState(() {
                    _list.removeAt(index);
                    print(_list);
                });
            },
        );
    }

    Future<bool> _requestPop() {
        if (_userEdited) {
            showDialog(
                context: context,
                builder: (context) {
                    return AlertDialog(
                        title: Text("Descartar alterações?"),
                        content: Text("As alterações serão perdidas."),
                        actions: <Widget>[
                            FlatButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                    Navigator.pop(context);
                                },
                            ),
                            FlatButton(
                                child: Text("Sim"),
                                onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                },
                            ),
                        ],
                    );
                }
            );
            return Future.value(false);
        } else {
            return Future.value(true);
        }
    }

    List _addShopping() {
        setState(() {
            if (shoppingListController.text != '') {
                _list.add(shoppingListController.text.replaceAll(",", ""));
                shoppingListController.text = '';
            }
        });
        return _list;
    }

    Future<http.Response> _postRequest() async {
        prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        var url = 'https://helppy-19.herokuapp.com/list';
        return http.post(
            url,
            headers: {"Content-Type": "application/json; charset=utf-8", HttpHeaders.authorizationHeader: "Bearer $token"},
            body: jsonEncode(<String, String>{
                "title": titleListController.text,
                'description': descriptionController.text,
                'shoppings': _list.toString(),
                "status": "0"
            })
        );
    }

    String capitalize(String s) {
        return s[0].toUpperCase() + s.substring(1);
    }

    alertCard(BuildContext context, String title, String text)
    {
        Widget okButton = FlatButton(
            child: Text("OK"),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                        return ControlPage(true);
                    },
                ));
            },
        );
        AlertDialog alerta = AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
                okButton,
            ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return alerta;
            },
        );
    }
}
