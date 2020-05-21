import 'package:flutter/material.dart';
import 'package:helppyapp/controllers/controllerForgot.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
    final TextEditingController _email = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final controllerForgot = Provider.of<ControllerForgot>(context);
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
                                        decoration: InputDecoration(
                                            labelText: "Email",
                                            errorText: controllerForgot.isValidEmail ? null : "Insira um email válido",
                                            errorStyle: TextStyle(color: Colors.red),
                                            hintText: "Insira seu email cadastrado",
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                    ),
                                );
                            },
                        ),
                        Observer(
                          builder: (_) {
                              return Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: RaisedButton(
                                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                                      color: COR_AZUL,
                                      onPressed: controllerForgot.isValidEmail ? (){} : null,
                                      child: Text(
                                          "Recuperar senha",
                                          style: TextStyle(
                                              color: COR_BRANCO,
                                              fontSize: 16.0
                                          ),
                                      ),
                                  ),
                              );
                          },
                        )
                    ],
                ),
            ),
        );
    }
}
