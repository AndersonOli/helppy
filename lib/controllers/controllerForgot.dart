import 'package:mobx/mobx.dart';

part 'controllerForgot.g.dart';

class ControllerForgot = _ControllerForgot with _$ControllerForgot;

abstract class _ControllerForgot with Store {
    @observable
    String email = "";

    @observable
    bool isValidEmail = false;

    @action
    void verifyEmail(String value){
        RegExp exp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
        if(exp.hasMatch(value)){
            email = value;
        } else {
            email = "";
        }

        isValidEmail = exp.hasMatch(value);
    }

    void newPass(){

    }
}