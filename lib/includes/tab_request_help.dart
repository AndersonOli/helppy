import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class requestHelp extends StatefulWidget {
  @override
  _requestHelpState createState() => _requestHelpState();
}

class _requestHelpState extends State<requestHelp> {

  Color whiteStd = Color(0xFFE5E5E5);
  Color greyStd = Color(0xFFC4C4C4);
  Color blueStd = Color(0xFF0049FF);



  final shoppingListController = TextEditingController();
  final titleListController = TextEditingController();
  final descriptionController = TextEditingController();


  List _shoppingList = [];
  List _list = [];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  List _addShopping() {
    setState(() {
      _list.add(shoppingListController.text);
      shoppingListController.text = '';
      return _list;
    });
  }

  void _addData() {
    setState(() {
      Map<String, dynamic> newshoppingList = Map();
      newshoppingList['id'] = _shoppingList.length + 1;
      newshoppingList['title'] = titleListController.text;
      newshoppingList['description'] = descriptionController.text;
      newshoppingList['shoppings'] = _list;
      _shoppingList.add(newshoppingList);
      _saveData();

      shoppingListController.text = '';
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
  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _shoppingList = json.decode(data);
        print(_shoppingList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueStd,
      ),

      floatingActionButton: FloatingActionButton(
      onPressed: _addData,
      child: Icon(Icons.check,color: whiteStd,),
      backgroundColor: blueStd,
      ),

      backgroundColor: whiteStd,
      body: Column(
        children: <Widget>[
          Divider(),
          Container(
            height: 45,
            child: TextField(
              controller: titleListController,
              decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                  hintText: 'Digite aqui'),
            ),
          ),
          Divider(),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                hintText: 'Digite aqui'),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Container(
                height: 45,
                width: 310,
                child: TextField(
                    controller: shoppingListController,
                    decoration: InputDecoration(
                        labelText: 'Adicione seu produto',
                        border: OutlineInputBorder(),
                        hintText: 'Digite aqui')),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10) ,
                child: Container(
                  height: 45,
                  child: RaisedButton(
                    child: Text('ADD'),
                    color: greyStd,
                    onPressed: _addShopping,
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: Divider(color: Colors.black)),
          Expanded(
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return builditem(context, index);
                }),
          )
        ],
      ),
    );
  }

  Widget builditem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.white12,
        child: Align(
            alignment: Alignment(-0.9, 0),
            child: Icon(
              Icons.delete,
              color: blueStd,
            )),
      ),
      direction: DismissDirection.startToEnd,
      child: Text(_list[index],
          style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
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
}