import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/ui/control_page.dart';
import 'package:provider/provider.dart';
import 'controllers/controllerCadastro.dart';
import 'controllers/controllerTab.dart';
import 'controllers/controllerTabHome.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(){
    runApp(
        MultiProvider(
            providers: [
                Provider<HomeController>(
                    create: (_) => HomeController(),
                ),
                Provider<ControllerTabHome>(
                    create: (_) => ControllerTabHome(),
                ),
                Provider<ControllerCadastro>(
                    create: (_) => ControllerCadastro(),
                ),
            ],
            child: MaterialApp(
                home: ControlPage(false),
                localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate
                ],
                supportedLocales: [
                    const Locale('pt', 'BR')
                ],
                theme: ThemeData(
                    fontFamily: 'NunitoSans',
                    inputDecorationTheme: InputDecorationTheme(
                        enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: COR_STROKE)),
                        focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: COR_AZUL)),
                        hintStyle: TextStyle(color: Colors.black),
                    ),
                ),
            ),
        )
    );
}