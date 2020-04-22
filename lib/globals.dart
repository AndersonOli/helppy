import 'package:flutter/material.dart';

//const Color COR_AZUL = Color.fromRGBO(0, 73, 255, 1);
const Color COR_AZUL = Color.fromRGBO(0, 59, 131, 1);
const Color COR_CINZA = Color.fromRGBO(161, 161, 161, 1);
const Color COR_BRANCO = Color.fromRGBO(240, 240, 240, 1);
const Color COR_STROKE = Color.fromRGBO(230, 227, 227, 1);


showAlertDialog(BuildContext context, String title, String text)
{
    // configura o button
    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
            Navigator.of(context).pop();
        },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
            okButton,
        ],
    );
    // exibe o dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
            return alerta;
        },
    );
}