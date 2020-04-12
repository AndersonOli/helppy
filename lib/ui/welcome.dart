import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final _width = MediaQuery.of(context).size.width;
      final _height = MediaQuery.of(context).size.height;
      return SingleChildScrollView(
          child: Container(
              height: _height,
              child: Center(
                  child: Text("Welcome screen here", style: TextStyle(color: Colors.black , decoration: TextDecoration.none),),
              ),
          ),
      );
  }
}
