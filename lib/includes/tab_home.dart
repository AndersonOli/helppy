import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
    @override
    _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
    var prefs;

    getResponseList() async {
        prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        final idUser = prefs.getInt('user_id');
        final response = await http.get(
            'https://helppy-19.herokuapp.com/list/$idUser',
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );
        return json.decode(response.body);
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    Expanded(
                        child: FutureBuilder(
                            future: getResponseList(),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                        return Center(
                                            child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
                                                strokeWidth: 5.0,
                                            ),
                                        );
                                    case ConnectionState.done:
                                        return _listCard(context, snapshot);
                                        break;
                                    default:
                                        if (snapshot.hasError) {
                                            return Container();
                                        } else {
                                            return _listCard(context, snapshot);
                                        }
                                }
                            }),
                    ),
                ],
            ),
        );
    }

    Widget _listCard(BuildContext context, AsyncSnapshot snapshot) {
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;
        return snapshot.data["list"].length > 0 ? SingleChildScrollView(
            child: Container(
                width: _width,
                height: _height,
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: ListView.builder(
                    itemCount: snapshot.data["list"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                        return _cardPedido(context, snapshot, index);
                    },
                ),
            ),
        ) : Center(
            child: Text(
                prefs.getString('type_acc') == "0" ? "Não há pedidos para ajudar no momento." : "Você ainda não fez nenhum pedido. Se precisa de ajuda, clique no botão com o + abaixo..",
                style: TextStyle(
                    color: COR_AZUL,
                    fontSize: 18.0,
                ),
            ),
        );
    }


    Widget _cardPedido(BuildContext context, AsyncSnapshot snapshot, int index){
        final _width = MediaQuery.of(context).size.width;
        return Container(
            width: _width,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Pedido de " + snapshot.data["name"],
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: OutlineButton(
                                        onPressed: (){},
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            "Ver pedido".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ),
                                SizedBox(
                                    width: 10.0,
                                ),
                                Expanded(
                                    child: OutlineButton(
                                        onPressed: (){},
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            "Aceitar pedido".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text(
                                    "Em " + snapshot.data["list"][index]["updated_at"].substring(0, 10).replaceAll("-", "/"),
                                    style: TextStyle(
                                        color: COR_BRANCO,
                                        fontSize: 14.0,
                                    ),
                                ),
                                Row(
                                    children: <Widget>[
                                        Icon(Icons.location_on, size: 14.0, color: COR_BRANCO,),
                                        Text(
                                            "200m",
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                        )
                                    ],
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }


    transformStringInList(int idList) async {
        String buildText = '';
        List list = [];
        var response = await getResponseList();
        String replaceString = response[idList]['shoppings'].toString().replaceAll(
            ",", "").replaceAll("[", "").replaceAll("]", "");
        for (var i = 0; i < replaceString.length; i++) {
            if (replaceString[i] != ' ') {
                buildText += replaceString[i];
            }
            if ((i == (replaceString.length - 1)) ||
                (replaceString[i] == ' ')) {
                list.add(buildText);
                buildText = '';
            }
        }
        print(list);
        return list;
    }
}



