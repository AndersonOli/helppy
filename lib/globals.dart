import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

//const Color COR_AZUL = Color.fromRGBO(0, 73, 255, 1);
const Color COR_AZUL = Color.fromRGBO(0, 59, 131, 1);
const Color COR_CINZA = Color.fromRGBO(161, 161, 161, 1);
const Color COR_BRANCO = Color.fromRGBO(240, 240, 240, 1);
const Color COR_STROKE = Color.fromRGBO(230, 227, 227, 1);
const Color COR_PRETA = Color.fromRGBO(17, 17, 17, 1);

showAlertDialog(BuildContext context, String title, String text)
{
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
        builder: (BuildContext context) {
            return alerta;
        },
    );
}

isLoading(BuildContext context, bool isloading){
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

requestPermission() async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.checkPermissionStatus(PermissionGroup.locationWhenInUse);

    switch (result) {
        case PermissionStatus.denied:
            await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
            var check = await _permissionHandler.checkPermissionStatus(PermissionGroup.locationWhenInUse);

            switch (check) {
                case PermissionStatus.denied:
                    SystemNavigator.pop();
                    break;
            }

            break;
    }
}

Widget loadingCenter() {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
            strokeWidth: 5.0,
        ),
    );
}