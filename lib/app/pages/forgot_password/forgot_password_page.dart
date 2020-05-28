import 'package:flutter/material.dart';
import 'package:helppyapp/app/controllers/forgot_password_controller.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
    @override
    _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    final TextEditingController _emailController = TextEditingController();

    @override
    void initState() {
        super.initState();
        final controller = ForgotPasswordController();

        autorun((_){
            print("hi");
            if(controller.emailExists == true){
                showAlertDialog(context, "Email enviado!", "Verifique seu email e siga as instruções.");
            } else {
                showAlertDialog(context, "Email não encontrado!", "Verifique se o email foi digitado corretamente, ou cadastre-se.");
            }
        });

//        autorun((_){
//            print("hi");
//            final controller = Provider.of<ControllerForgot>(context);
//

//
//            if(controller.isValidCode == false){
//                showAlertDialog(context, "Código inválido", "Verifique seu email novamente e garanta que digitou o código corretamente.");
//            }
//
//            if(controller.passwordChanged == true){
//                showAlertDialog(context, "Senha alterada!", "Seua senha foi alterada com sucesso.");
//
//                Navigator.of(context).pushReplacement(MaterialPageRoute(
//                    builder: (context){
//                        return ControlPage();
//                    }
//                ));
//            } else if(controller.passwordChanged == false){
//                showAlertDialog(context, "Não foi possível alterar a senha", "Não foi possível alterar a senha, tente novamente mais tarde.");
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context){
//                        return ChangePassword();
//                    }
//                ));
//            }
//        });
    }

    @override
    Widget build(BuildContext context) {
        final controllerForgot = Provider.of<ForgotPasswordController>(context);
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


