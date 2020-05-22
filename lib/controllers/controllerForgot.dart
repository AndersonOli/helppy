import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/ui/change_password.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'controllerForgot.g.dart';

class ControllerForgot = _ControllerForgot with _$ControllerForgot;

abstract class _ControllerForgot with Store {
    @observable
    String email = "";

    @observable
    bool isValidEmail = false;

    @action
    void verifyEmail(String value){
        RegExp exp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
        if(exp.hasMatch(value)){
            email = value;
        } else {
            email = "";
        }

        isValidEmail = exp.hasMatch(value);
    }

    @observable
    bool onLoading = false;

    @observable
    bool emailExists;

    @observable
    bool isValidCod = false;

    void newPass(context) async {
        var response;
        onLoading = true;

        try {
            response = await http.post(
                API_URL + '/sendEmail',
                body: <String, String>{
                    "email": email
                }
            );
        } catch(error) {
            if(error.toString().contains('E_MISSING_DATABASE_ROW')){
                print('Email inexistente');
            }
        }

        onLoading = false;

        switch(response.statusCode){
            case 204:
                emailExists = true;
                showAlertDialog(context, "Email enviado!", "Verifique seu email e siga as instruções.", false);
                break;
            case 404:
                emailExists = false;
                isValidEmail = false;
                showAlertDialog(context, "Email não encontrado!", "Verifique se o email foi digitado corretamente, ou cadastre-se.", true);
                break;
        }
    }

    void showAlertDialog(BuildContext context, String title, String text, bool pop) {
        Widget okButton = FlatButton(
            child: Text("OK"),
            onPressed: () {
                if(pop){
                    Navigator.of(context).pop();
                } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                            return ChangePassword();
                        }
                    ));
                }
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
}