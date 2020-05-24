import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
part 'controllerCadastro.g.dart';

class ControllerCadastro = _ControllerCadastro with _$ControllerCadastro;

abstract class _ControllerCadastro with Store {
    @observable
    var fileProfileImage;

    @action
    void changeProfileImage(dynamic value) => fileProfileImage = value;

    @observable
    String name = "";

    @action
    void newName(String value) => name = value;

    String validateFullName() {
        String pattern = r'^[a-z A-Z,.\-]+$';
        RegExp regExp = new RegExp(pattern);

        if (!regExp.hasMatch(name.trim())) {
            return 'Por favor digite um nome completo válido.';
        }

        return null;
    }
// copiar do que o Anderson já fez
    @observable
    String email = "";

    @action
    void newEmail(String value) => email = value;

    @observable
    String password = "";

    @action
    void newPassword(String value) => password = value;

    String validatePassword() {
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])$';
        RegExp regExp = new RegExp(pattern);

        if (regExp.hasMatch(password) == false) {
            //alterar para popup, não dá pra ler, muita informação
            //valildar se os dois campos de senhas sao iguais
            //validar se é maior que 6 caracters
            // verificar se essa exp regex esta correta: senha Aa123456 dá erro
            return 'A senha precisa conter pelo menos um carácter maiúsculo, minúsculo e numeral.'; //creio que só precisa ter 6 caracters, como o foco é idoso
        }
        return null;
    }

    @observable
    String telephone = "";

    @action
    void newTelephone (String value) => telephone = value;

    String validateTelephone () {
        String pattern = r'^([1-9]{2}) (?:[2-8]|9[1-9])[0-9]{3}[0-9]{4}$';
        RegExp regExp = new RegExp(pattern);

        if (regExp.hasMatch(telephone) == false) {
            //alterar para popup, não dá pra ler, muita informação
            return 'O seu telefone deve está nesse parâmetro ddd xxxxxxxxx, o ddd sem o 0 a esquerda';
        }

        return null;
    }

    @computed
    bool get isValid {
        return validateFullName() == null && validateTelephone() == null && validatePassword() == null;
    }

    //fazer requests do cadastro aqui dentro: doCadastro, complete CEP etc
}