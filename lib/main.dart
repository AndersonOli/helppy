import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';
import 'package:helppyapp/includes/tab_home.dart';
import 'package:helppyapp/ui/control_page.dart';
import 'package:helppyapp/includes/tab_request_help.dart';

void main(){
    runApp(MaterialApp(
        home: HomeTab(),
        theme: ThemeData(
            fontFamily: 'NunitoSans',
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: COR_STROKE)),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: COR_AZUL)),
                hintStyle: TextStyle(color: Colors.black),
            ),
        ),
    ));
}