import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';

Widget loadingCenter({Color color}) {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color ?? COR_AZUL),
            strokeWidth: 5.0,
        ),
    );
}

void showAlertDialog(BuildContext context, String title, String text) {
    Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
            Navigator.of(context).pop();
        },
    );
    AlertDialog alerta = AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
            okButton,
        ],
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
            return alerta;
        },
    );
}

void isLoading(BuildContext context, bool isloading){
    if(isloading){
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
                        strokeWidth: 5.0,
                    ),
                );
            },
        );
    } else {
        Navigator.of(context).pop();
    }
}