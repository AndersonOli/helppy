import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/controllers/controllerForgot.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
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
                                    child: TextField(
                                        decoration: InputDecoration(
                                            labelText: "Código",
                                            errorText: "Insira um código válido",
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
                                        onPressed: (){},
                                        child: Container(
                                            width: 180.0,
                                            height: 40.0,
                                            alignment: Alignment.center,
                                            child: false == true ? SizedBox(
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
