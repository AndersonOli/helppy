import 'dart:async';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:helppyapp/globals.dart';

class WelcomeScreen extends StatefulWidget {
    @override
    _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
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
                                    margin: EdgeInsets.only(top: 50.0),
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
                                )
                            ],
                        ),
                    ),
                    Container(
                        width: _width,
                        color: Colors.red,
                    ),
                    Container(
                        width: _width,
                        color: Colors.green,
                    ),
                ],
            ),
        );
    }
}
