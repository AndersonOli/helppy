import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/globals.dart';

class HomeTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Center(
            child: RaisedButton(
                onPressed: transformStringInList,
            ),
        );
    }

    Future getResponseList() async {
        final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU4NzU5MjMzNSwiZXhwIjozMTg3MTMxOTA0MDd9.i_7rWLf1n5Ju8mGSIcI1yojrkdgWFyaLCawVHro413k';
        final idUser = 1;
        final response = await http.get(
            'http://10.0.2.2:3333/list/$idUser',
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );
        return json.decode(response.body);
    }

    transformStringInList() async {
        String buildText = '';
        List list = [];
        var response = await getResponseList();
        String replaceString = response['shoppings'].toString().replaceAll(
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
//
//class HomeTab extends StatelessWidget {
//    @override
//    Widget build(BuildContext context) {
//        final _width = MediaQuery.of(context).size.width;
//        final _height = MediaQuery.of(context).size.height;
//        return SingleChildScrollView(
//            child: Container(
//                width: _width,
//                height: _height,
//                padding: EdgeInsets.only(right: 10.0, left: 10.0),
//                child: ListView.builder(
//                    itemCount: 10,
//                    shrinkWrap: true,
//                    itemBuilder: (context, index){
//                        return _cardPedido(context);
//                    },
//                ),
//            ),
//        );
//    }
//
//    Widget _cardPedido(context){
//        final _width = MediaQuery.of(context).size.width;
//        return Container(
//            width: _width,
//            height: 200.0,
//            margin: EdgeInsets.only(top: 10.0),
//            decoration: BoxDecoration(
//                color: COR_AZUL,
//                borderRadius: BorderRadius.circular(10.0)
//            ),
//        );
//    }
//}


