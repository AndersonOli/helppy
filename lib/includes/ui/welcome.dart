import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helppyapp/controllers/controllerTab.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/general/tab_cadastro.dart';
import 'package:helppyapp/includes/ui/forgot_password.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'control_page.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';

class WelcomeScreen extends StatefulWidget {
    final String tokenNotification;
    WelcomeScreen(this.tokenNotification);
    @override
    _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
    final TextEditingController _emailLoginController = TextEditingController();
    final TextEditingController _senhaLoginController = TextEditingController();

    @override
    void initState() {
        super.initState();
        requestPermission();
    }

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final controller = Provider.of<HomeController>(context);
        return Scaffold(
            body: PageView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                    SingleChildScrollView(
                        child: Column(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 75.0, bottom: 25.0),
                                    width: 200.0,
                                    height: 200.0,
                                    child: Image(
                                        image: AssetImage("assets/images/logo.png"),
                                    ),
                                ),
                                Text(
                                    "Seja bem vindo(a) ao Helppy-19",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: COR_AZUL,
                                        fontFamily: 'Nunito',
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                                Container(
                                    width: _width-40.0,
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                        "\t\tO Helppy-19 é um aplicativo que surgiu em meio a uma pandemia para ajudar. O intuito do aplicativo é ajudar as pessoas do grupo de risco (idosos principalmente)  a fazer compras, se você é idoso nesse aplicativo existem pessoas que podem te ajudar, se você quer ajudar, também tem espaço.",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Color.fromRGBO(4, 75, 155, 1.0),
                                            fontFamily: 'Nunito',
                                            fontSize: 18.0,
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 50.0, bottom: 30.0),
                                    width: 300.0,
                                    height: 70.0,
                                    child: Animator (
                                        tweenMap: {
                                            "translation": Tween<Offset>(
                                                begin: Offset(0.4, 0),
                                                end: Offset(-0.4, 0),
                                            ),
                                            "opacity": Tween<double>(
                                                begin: 1,
                                                end: 0,
                                            ),
                                        },
                                        duration: Duration(milliseconds: 1800),
                                        curve: Curves.ease,
                                        repeats: 0,
                                        builderMap: (Map<String, Animation> anim) => FadeTransition(
                                            opacity: anim["opacity"],
                                            child: FractionalTranslation(
                                                translation: anim["translation"].value,
                                                child: Image(
                                                    image: AssetImage("assets/images/hand.png"),
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                                Text(
                                    "Passe para o lado",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: COR_AZUL,
                                        fontFamily: 'Nunito',
                                        fontSize: 16.0,
                                    ),
                                ),
                            ],
                        ),
                    ),
                    SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 70.0, bottom: 10.0),
                                    width: _width,
                                    height: 150.0,
                                    child: Image(
                                        image: AssetImage("assets/images/logov2.png"),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Divider(
                                        color: COR_STROKE,
                                    ),
                                ),
                                Container(
                                    width: _width,
                                    child: RaisedButton(
                                        onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                    return CadastroPage(widget.tokenNotification);
                                                },
                                            ));
                                        },
                                        color: COR_AZUL,
                                        child: Text(
                                            "Não tem uma conta? Cadastre-se",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 16.0,
                                            ),
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Divider(
                                        color: COR_STROKE,
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: TextFormField(
                                        validator: (value){
                                            if(value.isEmpty){
                                                return "Insira um email";
                                            } else {
                                                return null;
                                            }
                                        },
                                        controller: _emailLoginController,
                                        decoration: InputDecoration(
                                            labelText: "Email",
                                            hintText: "Insira seu email",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            const EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                    ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
                                    child: TextField(
                                        obscureText: true,
                                        controller: _senhaLoginController,
                                        onSubmitted: (e){
                                            _doLogin(context, controller);
                                        },
                                        decoration: InputDecoration(
                                            labelText: "Senha",
                                            hintText: "Insira sua senha",
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                            const EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                    ),
                                ),
                                Row(
                                    children: <Widget>[
                                        Expanded(
                                            child: GestureDetector(
                                                onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (_){
                                                            return ForgotPassword();
                                                        }
                                                    ));
                                                },
                                                child: Text(
                                                    "Esqueci minha senha",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: COR_AZUL,
                                                        fontSize: 18.0,
                                                        decoration: TextDecoration.underline,
                                                    ),
                                                ),
                                            ),
                                        ),
                                        Expanded(
                                            child: RaisedButton(
                                                onPressed: () {
                                                    _doLogin(context, controller);
                                                },
                                                color: COR_AZUL,
                                                child: Text(
                                                    "Entrar",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: COR_BRANCO,
                                                        fontSize: 18.0,
                                                    ),
                                                ),
                                            ),
                                        )
                                    ],
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    _doLogin(BuildContext context, HomeController controller) async {
        if(_emailLoginController.text != "" && _senhaLoginController.text != ""){
            isLoading(context, true);
            http.Response data = await http.post(
                API_URL + '/authenticate',
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                    "email": _emailLoginController.text.trim(),
                    "password": _senhaLoginController.text,
                    "token_notification": widget.tokenNotification
                }),
            );
            var dados = json.decode(data.body);
            isLoading(context, false);
            try{
                if(dados[0]["field"] != null){
                    showAlertDialog(
                        context,
                        "Email ou senha inválidos",
                        "Por favor, verifique se seu email e senha estão corretos."
                    );
                }
            } catch(e) {
                controller.setPreferences('logged', 1);
                controller.setPreferences('token', dados["token"]);
                controller.setPreferences('user_id', dados["user_id"]);
                controller.setPreferences('type_acc', dados["type_account"].toString());
                controller.setPreferences('name', dados["full_name"]);

                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                        return ControlPage();
                    },
                ));
            }
        }
    }
}
