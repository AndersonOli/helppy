import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/App/Pages/Register/register_page.dart';
import 'package:helppyapp/app/pages/forgot_password/forgot_password_page.dart';
import 'package:provider/provider.dart';


class WelcomeScreen extends StatefulWidget {
    final String tokenNotification;
    WelcomeScreen(this.tokenNotification);
    @override
    _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

    @override
    void initState() {
        super.initState();
        requestPermission();
    }

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final controller = Provider.of<MainTabController>(context);
        final controllerSignIn = provider.of<SignInController>(context);
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
                                    child: TextField(
                                       onChanged: controllerSignIn.newEmail,
                                        controller: controllerSignIn.emailLoginController,
                                        decoration: InputDecoration(
                                            errorText: controllerSignIn.validateEmail,
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
                                        onChanged: controllerSignIn.newPassword,
                                        obscureText: true,
                                        controller: controllerSignIn.senhaLoginController,
                                        onSubmitted: (e){
                                            controllerSignIn.signIn(context, controller, widget.tokenNotification);
                                        },
                                        decoration: InputDecoration(
                                            errorText: controllerSignIn.validatePassword(),
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
                                                    controllerSignIn.signIn(context, controller, widget.tokenNotification);
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
}
