import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'main_tab_controller.dart';
part 'sign_in_controller.g.dart';

class SignInController = _SignInController with _$SignInController;

abstract class _SignInController with Store {
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController senhaLoginController = TextEditingController();

  @observable
  String email = "";

  @action
  void newEmail(String value) => email = value;

  @computed
  dynamic get validateEmail {
    RegExp exp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if(exp.hasMatch(email) == true || email.length < 1){
      return null;
    }

    return "Insira um email válido";
  }

  @observable
  String password = "";

  @action
  void newPassword(String value) => password = value;

  @observable
  bool statusSignIn;

  Future<void> signIn(BuildContext context, MainTabController controller, var tokenNotification) async {
    if(emailLoginController.text != "" && senhaLoginController.text != ""){
      isLoading(context, true);
      http.Response data = await http.post(
        API_URL + '/authenticate',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": emailLoginController.text.trim(),
          "password": senhaLoginController.text,
          "token_notification": tokenNotification
        }),
      );
      var dados = json.decode(data.body);
      isLoading(context, false);
      try{
        if(dados[0]["field"] != null){
          // email or password wrong
          statusSignIn = false;
        }
      } catch(e) {
        // login success
        statusSignIn = true;
        controller.setPreferences('logged', 1);
        controller.setPreferences('token', dados["token"]);
        controller.setPreferences('user_id', dados["user_id"]);
        controller.setPreferences('type_acc', dados["type_account"].toString());
        controller.setPreferences('name', dados["full_name"]);
      }
    }
  }
}