import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:helppyapp/globals.dart';
import 'package:helppyapp/includes/tab_cadastro.dart';
import 'package:http/http.dart' as http;
import 'control_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
    @override
    _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
    final TextEditingController _emailLoginController = TextEditingController();
    final TextEditingController _senhaLoginController = TextEditingController();
    var prefs;

    @override
    void initState() {
        super.initState();
        setValue();
        requestPermission();
    }

    void setValue() async {
        prefs = await SharedPreferences.getInstance();
    }

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;
        return Scaffold(
            body: CarouselSlider(
                options: CarouselOptions(
                    height: _height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: false,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                ),
                items: <Widget>[
                    Container(
                        width: _width,
                        height: _height,
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
                                        "\t\tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
//                        width: _width,
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
                                                    return CadastroPage();
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
                                            _doLogin(context);
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
                                        Expanded(
                                            child: RaisedButton(
                                                onPressed: () {
                                                    _doLogin(context);
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
                    ),
                ],
            ),
        );
    }

    _doLogin(BuildContext context) async {
        if(_emailLoginController.text != "" && _senhaLoginController.text != ""){
            isLoading(context, true);
            http.Response data = await http.post(
                'https://helppy-19.herokuapp.com/authenticate',
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                    "email": _emailLoginController.text.trim(),
                    "password": _senhaLoginController.text
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
                prefs.setInt('logged', 1);
                prefs.setString('token', dados["token"]);
                prefs.setInt('user_id', dados["user_id"]);
                prefs.setString('type_acc', dados["type_account"]);
                prefs.setString('name', dados["full_name"]);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                        return ControlPage(true);
                    },
                ));
            }
        }
    }
}
