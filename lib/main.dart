import 'package:flutter/material.dart';
import 'package:helppyapp/ui/control_page.dart';
import 'package:google_fonts/google_fonts.dart';


void main(){
    runApp(MaterialApp(
        home: ControlPage(),
        theme: ThemeData(
            fontFamily: 'NunitoSans',
        ),
    ));
}