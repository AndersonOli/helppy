import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/components/control/control_page_component.dart';
import 'package:helppyapp/app/controllers/forgot_password_controller.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
    @override
    _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
    ForgotPasswordController controllerForgot = ForgotPasswordController();

    @override
    void initState() {
        super.initState();

        autorun((_){
            if(controllerForgot.passwordChanged == true){
                dialog(
                    context,
                    title: "Senha alterada!",
                    body: "Sua senha foi alterada com sucesso :)",
                    method: "pushReplacement",
                    route: MaterialPageRoute(
                        builder: (context){
                            return ControlPage();
                        }
                    )
                );
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: COR_AZUL,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.contain,
                                width: 100.0,
                            ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Text(
                                "\t\t\t\tstandard dummy text ever since the of type and scrambled it to make a type specimen book.",
                                style: TextStyle(
                                    color: COR_AZUL,
                                    fontSize: 16.0
                                ),
                                textAlign: TextAlign.justify,
                            ),
                        ),
                        Observer(
                            builder: (context){
                                return Container(
                                    margin: EdgeInsets.only(top: 40.0),
                                    child: controllerForgot.isValidCode == true ?
                                    Column(
                                        children: <Widget>[
                                            Observer(
                                                builder: (_){
                                                    return Container(
                                                        margin: EdgeInsets.only(bottom: 10.0),
                                                        child: TextField(
                                                            onChanged: controllerForgot.setPassword,
                                                            decoration: InputDecoration(
                                                                labelText: "Senha",
                                                                errorText: controllerForgot.errorText == "" ? null : controllerForgot.errorText,
                                                                errorStyle: TextStyle(color: Colors.red),
                                                                hintText: "Insira uma nova senha",
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                            )
                                                        ),
                                                    );
                                                },
                                            ),
                                            Observer(
                                                builder: (_){
                                                    return Container(
                                                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                        child: TextField(
                                                            onChanged: controllerForgot.setConfirmPassword,
                                                            decoration: InputDecoration(
                                                                labelText: "Confirme",
                                                                errorText: controllerForgot.errorText == "" ? null: controllerForgot.errorText,
                                                                errorStyle: TextStyle(color: Colors.red),
                                                                hintText: "Confirme sua senha novamente",
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                            )
                                                        ),
                                                    );
                                                },
                                            ),
                                        ],
                                    ) : TextField(
                                        onChanged: controllerForgot.setCode,
                                        maxLength: 6,
                                        decoration: InputDecoration(
                                            labelText: "Código",
                                            errorText: controllerForgot.verifyCode.length > 0 && controllerForgot.verifyCode.length < 6 ? "Insira um código válido" : null,
                                            errorStyle: TextStyle(color: Colors.red),
                                            hintText: "Insira o código inserido no seu email",
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                    ),
                                );
                            },
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top: 10.0),
                            child: Observer(
                                builder: (_) {
                                    return RaisedButton(
                                        color: COR_AZUL,
                                        onPressed: controllerForgot.verifyCode.length == 6 && controllerForgot.errorText == "" ? (){
                                            if(controllerForgot.errorText == "" && controllerForgot.isValidCode == true){
                                                controllerForgot.changePassword();
                                            } else {
                                                controllerForgot.validCode(context);
                                            }
                                        } : null,
                                        child: Container(
                                            width: 180.0,
                                            height: 40.0,
                                            alignment: Alignment.center,
                                            child: controllerForgot.onLoading ? SizedBox(
                                                width: 25.0,
                                                height: 25.0,
                                                child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(COR_BRANCO),
                                                    strokeWidth: 3.0,
                                                ),
                                            ) : Text(
                                                "Confirmar",
                                                style: TextStyle(
                                                    color: COR_BRANCO,
                                                    fontSize: 16.0
                                                ),
                                            ),
                                        )
                                    );
                                },
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}
