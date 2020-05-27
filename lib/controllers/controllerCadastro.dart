import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helppyapp/controllers/controllerTab.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';
import 'package:location/location.dart';
part 'controllerCadastro.g.dart';

class ControllerCadastro = _ControllerCadastro with _$ControllerCadastro;

abstract class _ControllerCadastro with Store {
    final TextEditingController nomeCadController = TextEditingController();
    final TextEditingController emailCadController = TextEditingController();
    final TextEditingController senhaCadController = TextEditingController();
    final TextEditingController confirmSenhaCadController = TextEditingController();
    final TextEditingController telCadController = TextEditingController();
    final TextEditingController cepCadController = TextEditingController();
    final TextEditingController endCadController = TextEditingController();
    final TextEditingController numeroCadController = TextEditingController();
    final TextEditingController refCadController = TextEditingController();

    @observable
    var fileProfileImage;

    @action
    void changeProfileImage(dynamic value) => fileProfileImage = value;

    @observable
    String name = "";

    @action
    void newName(String value) => name = value;

    dynamic validateFullName() {
        String pattern = r'^[a-z A-Z,.\-]+$';
        RegExp regExp = new RegExp(pattern);

        if (!regExp.hasMatch(name.trim()) && name.length > 0) {
            return 'Por favor digite um nome completo válido.';
        }

        return null;
    }

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

    String validatePassword() {
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
        RegExp regExp = new RegExp(pattern);
        if (regExp.hasMatch(password) == false && password.length > 0) {
            //alterar para popup, não dá pra ler, muita informação
            return 'Senha inválida, exemplo de senha válida: Aa1234';
        }

        return null;
    }

    @observable
    String confirmPassword = "";

    @action
    void newConfirmPassword(String value) => confirmPassword = value;

    String validateConfirmPasswod() {
        if(password == confirmPassword || confirmPassword.length < 1) {
            return null;
        }
        return "As senhas não são iguais";
    }

    @observable
    String telephone = "";

    @action
    void newTelephone (String value) => telephone = value;

    String validateTelephone() {
        String pattern = r'^([1-9]{2})(?:[2-8]|9[1-9])[0-9]{3}[0-9]{4}$';
        RegExp regExp = new RegExp(pattern);
        if (regExp.hasMatch(telephone) == true || telephone.length < 1) {
//            showAlertDialog(context,
//                'Número de telefone incorreto',
//                'O seu telefone deve está nesse parâmetro dddxxxxxxxxx, o ddd sem o 0 a esquerda'
//            );
            return null;
        }
        return "Seu número de telefone está inválido";
    }

    @observable
    String cep = "";

    @observable
    var errortextCep = "";

    var latitude;
    var longitude;

    @action
    Future<dynamic> newCep(String value) async {
        cep = value;

        if (cep.length > 1 && cep.length < 8) {
            errortextCep = "CEP tem que ter 8 caracteres";
        } else {
            errortextCep = "";
            var endereco = await http.get(
                "http://www.cepaberto.com/api/v3/cep?cep=" + cep.trim(),
                headers: {'Authorization': 'Token token=471dec71c96f8dbc684056839dc3411b'}
            );
            var data = jsonDecode(endereco.body);

            if(data["latitude"] != null && data["longitude"] != null){
                latitude = data["latitude"];
                longitude = data["longitude"];
            } else {
                var location = new Location();
                var userLocation = await location.getLocation();
                latitude = userLocation.latitude;
                longitude = userLocation.longitude;
            }
            endCadController.text = data["logradouro"] + " - " + data["bairro"] + " - " + data["cidade"]["nome"] + "-" + data["estado"]["sigla"];
            refCadController.text = data["complemento"];
        }
    }

    @observable
    int typeAcc;

    @observable
    bool onProgress;

    @observable
    bool typeOne = false;

    @observable
    bool typeTwo = false;

    @observable
    File file;

    doCadastro(context, HomeController controller, var tokenNotification) async {
        if(fileProfileImage == null){
            showAlertDialog(
                context,
                "Insira uma imagem de perfil!",
                "Por favor, clique no ícone de perfil e insira uma imagem."
            );
            return null;
        }

        isLoading(context, true);

        typeAcc = typeOne == true ? 1 : 0;

        http.Response data = await http.post(
            API_URL + '/register',
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
                "full_name": nomeCadController.text,
                "email": emailCadController.text.toLowerCase().trim(),
                "password": senhaCadController.text,
                "telephone": telCadController.text.trim(),
                "cep": cepCadController.text.trim(),
                "address": endCadController.text,
                "house_number": numeroCadController.text.trim(),
                "reference": refCadController.text,
                "type_account": typeAcc.toString(),
                "latitude": latitude,
                "longitude": longitude,
                "token_notification": tokenNotification,
                "profile_picture": base64Encode(file.readAsBytesSync())
            }),
        );

        isLoading(context, false);

        if(data.body.contains('duplicate key value violates unique constraint')){
            showAlertDialog(
                context,
                "Este email já está em uso!",
                "Por favor, escolha um outro email, esse já está sendo usado."
            );
        } else if(data.body.contains('null value in column')){
            showAlertDialog(
                context,
                "Preencha todos os campos!",
                "Por favor, preencha todos os campos, verifique se você não esqueceu de algum."
            );
        } else if(data.body.contains(emailCadController.text.toLowerCase().trim())){
            http.Response data = await http.post(
                API_URL + '/authenticate',
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                    "email": emailCadController.text.toLowerCase().trim(),
                    "password": senhaCadController.text,
                    "token_notification": tokenNotification,
                }),
            );

            var dados = json.decode(data.body);

            print(dados);

//            Navigator.pushReplacement(context, MaterialPageRoute(
//                builder: (context) {
//                    controller.setPreferences('logged', 1);
//                    controller.setPreferences('token', dados["token"]);
//                    controller.setPreferences('user_id', dados["user_id"]);
//                    controller.setPreferences('type_acc', dados["type_account"].toString());
//                    controller.setPreferences('name', dados["full_name"]);
//                    return ControlPage();
//                },
//            ));
        }
    }
}