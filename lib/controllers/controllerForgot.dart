import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/ui/change_password.dart';
import 'package:helppyapp/includes/ui/control_page.dart';
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

    void newCode(context) async {
        var response;
        onLoading = true;

        try {
            response = await http.post(
                API_URL + "/sendEmail",
                body: <String, String>{
                    "email": email
                }
            );
        } catch(error) {
            print(error.toString());
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

    @observable
    String verifyCode = "";

    @action
    void setCode(String value) => verifyCode = value;

    @observable
    bool isValidCode;

    Future<void> validCode(context) async {
        var response;
        onLoading = true;

        try {
            response = await http.post(
                API_URL + "/validateToken",
                body: <String, String>{
                    "token": verifyCode
                }
            );
        } catch(error) {
            print(error.toString());
        }

        onLoading = false;

        if(response.body == "true"){
            isValidCode = true;
        } else {
            showAlertDialog(context, "Código inválido", "Verifique seu email novamente e garanta que digitou o código corretamente.", true);
        }
    }

    @observable
    String password = "";

    @action
    void setPassword(String value){
        password = value;
        if(password != confirmPassword && confirmPassword.length > 0){
            errorText = "As senhas não são iguais";
        } else {
            errorText = "";
        }
    }

    @observable
    String confirmPassword = "";

    @observable
    String errorText = "";

    @action
    void setConfirmPassword(String value){
        confirmPassword = value;
        if(password != confirmPassword){
            errorText = "As senhas não são iguais";
        } else {
            errorText = "";
        }
    }

    @observable
    bool passwordChanged;

    Future<void> changePassword(context) async {
        var response;
        onLoading = true;

        try {
            response = await http.post(
                API_URL + "/resetPassword",
                body: <String, String>{
                    "token": verifyCode,
                    "password": password
                }
            );
        } catch(error) {
            print(error.toString());
        }

        onLoading = false;

        if(response.statusCode == 204){
            passwordChanged = true;
            showAlertDialog(context, "Senha alterada!", "Seua senha foi alterada com sucesso.", false);
        } else {
            showAlertDialog(context, "Não foi possível alterar a senha", "Não foi possível alterar a senha, tente novamente mais tarde.", true);
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

                    if(passwordChanged == true){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context){
                                return ControlPage();
                            }
                        ));
                    } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context){
                                return ChangePassword();
                            }
                        ));
                    }
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