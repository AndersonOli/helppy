import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/control/control_page_component.dart';
import 'package:helppyapp/app/controllers/forgot_password_controller.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/pages/forgot_password/change_password_page.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
    @override
    _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    ForgotPasswordController controllerForgot = ForgotPasswordController();
    final TextEditingController _emailController = TextEditingController();

    @override
    void initState() {
        super.initState();

        autorun((_) async {
            if(controllerForgot.emailExists == true){
                dialog(
                    context,
                    title: "Email enviado!",
                    body: "Verifique seu email e siga as instruções.",
                    route: MaterialPageRoute(
                        builder: (context){
                            return ChangePassword();
                        }
                    )
                );
            } else {
                dialog(
                    context,
                    title: "Email não encontrado!",
                    body: "Verifique se o email foi digitado corretamente, ou cadastre-se.",
                    route: null
                );
            }

            if(controllerForgot.isValidCode == false){
                dialog(
                    context,
                    title: "Código inválido",
                    body: "Verifique seu email novamente e garanta que digitou o código corretamente.",
                    route: null
                );
            }

            if(controllerForgot.passwordChanged == true){
                dialog(
                    context,
                    title: "Senha alterada!",
                    body: "Seua senha foi alterada com sucesso.",
                    method: "pushReplacement",
                    route: MaterialPageRoute(
                        builder: (context){
                            return ControlPage();
                        }
                    )
                );
            } else if(controllerForgot.passwordChanged == false){
                dialog(
                    context,
                    title: "Não foi possível alterar a senha",
                    body: "Não foi possível alterar a senha, tente novamente mais tarde.",
                    route: MaterialPageRoute(
                        builder: (context){
                            return ChangePassword();
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
                        Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                            width: 100.0,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Text(
                                "\t\t\t\tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
                                    child: TextField(
                                        onChanged: controllerForgot.verifyEmail,
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                            labelText: "Email",
                                            errorText: controllerForgot.isValidEmail || _emailController.text.length < 1 ? null : "Insira um email válido",
                                            errorStyle: TextStyle(color: Colors.red),
                                            hintText: "Insira seu email cadastrado",
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
                                        onPressed: controllerForgot.isValidEmail && !controllerForgot.onLoading ? () async {
                                            await controllerForgot.newCode(context);
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
                                                "Recuperar senha",
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


