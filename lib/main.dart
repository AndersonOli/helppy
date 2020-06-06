import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/components/control/control_page_component.dart';
import 'package:helppyapp/app/controllers/settings_controller.dart';
import 'package:helppyapp/app/controllers/sign_in_controller.dart';
import 'package:provider/provider.dart';
import 'package:helppyapp/app/controllers/register_controller.dart';
import 'package:helppyapp/app/controllers/forgot_password_controller.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/controllers/home_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(){
    runApp(
        MultiProvider(
            providers: [
                Provider<HomeController>(
                    create: (_) => HomeController(),
                ),
                Provider<MainTabController>(
                    create: (_) => MainTabController(),
                ),
                Provider<RegisterController>(
                    create: (_) => RegisterController(),
                ),
                Provider<ForgotPasswordController>(
                    create: (_) => ForgotPasswordController(),
                ),
                Provider<SignInController>(
                  create: (_) => SignInController(),
                ),
                Provider<SettingsController>(
                    create: (_) => SettingsController(),
                )
            ],
            child: MaterialApp(
                home: ControlPage(),
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
                        labelStyle: TextStyle(color: COR_AZUL),
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