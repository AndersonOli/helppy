import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/ui/control_page.dart';
import 'package:provider/provider.dart';

import 'controllers/controllerTabHome.dart';

void main(){
    runApp(
        MaterialApp(
            home: ControlPage(false),
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
        )
    );
}