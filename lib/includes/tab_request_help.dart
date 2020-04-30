import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
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

    Future<http.Response> _resultAPI;
    bool _userEdited = false;
    List _shoppingList = [];
    List _list = [];
    Map<String, dynamic> _lastRemoved;
    int _lastRemovedPos;

    @override
    void initState() {
        super.initState();
        requestPermission();
        _readData().then((data) {
            setState(() {
                _shoppingList = json.decode(data);
                print(_shoppingList);
            });
        });
    }

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
                        _addData();
                        await _resultAPI.then((http.Response response) {
                            print(response.body);
                            return response.statusCode;
                        });
                    }, //_addData
                    child: Icon(
                        Icons.check,
                        color: COR_BRANCO,
                    ),
                    backgroundColor: COR_AZUL,
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
                                        hintText: "Descrição do pedido (opcional)",
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
                                            color: COR_AZUL,
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
                    _lastRemoved = Map.from(_list[index]);
                    _lastRemovedPos = index;
                    _list.removeAt(index);
                    _saveData();
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
                        title: Text("Descartar Alterações?"),
                        content: Text("As Alterações Serão Perdidas."),
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
                });
            return Future.value(false);
        } else {
            return Future.value(true);
        }
    }

    List _addShopping() {
        setState(() {
            if (shoppingListController.text != '') {
                _list.add(shoppingListController.text);
                shoppingListController.text = '';
            }
        });
        return _list;
    }

    void _addData() {
        setState(() {
            Map<String, dynamic> newshoppingList = Map();
            newshoppingList['title'] = titleListController.text;
            newshoppingList['description'] = descriptionController.text;
            newshoppingList['shoppings'] = _list;
            _shoppingList.insert(0, newshoppingList);
            //_saveData();

            shoppingListController.text = '';
            _resultAPI = postRequest();
        });
    }
    Future<File> _getFile() async {
        final directory = await getApplicationDocumentsDirectory();
        return File("${directory.path}/data.json");
    }

    Future<File> _saveData() async {
        String data = json.encode(_shoppingList);
        final file = await _getFile();
        return file.writeAsString(data);
    }

    Future<String> _readData() async {
        try {
            final file = await _getFile();
            return file.readAsString();
        } catch (e) {
            return null;
        }
    }

    Future<http.Response> postRequest() async {
        prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        var url = 'https://helppy-19.herokuapp.com/list';
        var body = _shoppingList[0];
        print(body);
        return http.post(
            url,
            headers: {"Content-Type": "aplication/json", HttpHeaders.authorizationHeader: "Bearer $token"},
            body: body
        );
    }

    String capitalize(String s) {
        return s[0].toUpperCase() + s.substring(1);
    }

    Future<void> requestPermission() async {
        final PermissionHandler _permissionHandler = PermissionHandler();
        var result = await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
    }
}
