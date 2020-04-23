import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/globals.dart';

class HomeTab extends StatelessWidget {
     getResponseList() async {
        final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU4NzU5MjMzNSwiZXhwIjozMTg3MTMxOTA0MDd9.i_7rWLf1n5Ju8mGSIcI1yojrkdgWFyaLCawVHro413k';
        final idUser = 1;
        final response = await http.get(
            'http://10.0.2.2:3333/list/$idUser',
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
      return SingleChildScrollView(
          child: Container(
              width: _width,
              height: _height,
              padding: EdgeInsets.only(right: 10.0, left: 10.0),
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                      return _cardPedido(context, snapshot);
                  },
              ),
          ),
      );
    }


    Widget _cardPedido(BuildContext context, AsyncSnapshot snapshot){
        final _width = MediaQuery.of(context).size.width;
        return Container(
            width: _width,
            height: 200.0,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
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
    }

}


