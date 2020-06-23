import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../components/general/globals_component.dart';
part 'settings_controller.g.dart';

class SettingsController = _SettingsController with _$SettingsController;

abstract class _SettingsController with Store {
  @observable
  var fileProfileImage;

  @observable
  var linkImg;

  @observable
  File file;

  @action
  void changeProfileImage(dynamic value){
    fileProfileImage = value;
    uploadImage();
  }

  Future<void> uploadImage() async {
    if (fileProfileImage != null) {
      final FirebaseStorage _storage =
          FirebaseStorage(storageBucket: 'gs://helppy-19-893b1.appspot.com');

      StorageUploadTask _task;

      var _ref = _storage.ref().child('images/${DateTime.now()}.png');

      _task = _ref.putFile(file);

      var _downloadLink = await(await _task.onComplete).ref.getDownloadURL();

      linkImg = _downloadLink.toString();
    }
  }

  @observable
  var data;

  @observable
  bool loading;

  Future recoveryValues(SharedPreferences prefs) async {
    loading = true;
    data = jsonDecode((await http.get(
      API_URL + '/account',
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer " + prefs.getString("token")
      },
    ))
        .body);

    fileProfileImage = data[0]["profile_picture"];
    emailUpdateController.text = data[0]["email"];
    telUpdateController.text = data[0]["telephone"];
    cepUpdateController.text = data[0]["cep"];
    endUpdateController.text = data[0]["address"];
    numeroUpdateController.text = data[0]["house_number"];
    refUpdateController.text = data[0]["reference"];

    loading = false;
    return data[0];
  }

  @observable
  String email = "";

  @action
  void newEmail(String value) => email = value;

  @computed
  dynamic get validateEmail {
    RegExp exp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (exp.hasMatch(email) == true || email.length < 1) {
      return null;
    }

    return "Insira um email válido";
  }

  var latitude, longitude;
  final TextEditingController emailUpdateController = TextEditingController();
  final TextEditingController telUpdateController = TextEditingController();
  final TextEditingController cepUpdateController = TextEditingController();
  final TextEditingController endUpdateController = TextEditingController();
  final TextEditingController numeroUpdateController = TextEditingController();
  final TextEditingController refUpdateController = TextEditingController();

  @observable
  int statusUpdate;

  @action
  Future<void> update(SharedPreferences prefs, BuildContext context) async {
    isLoading(context, true);
    if (fileProfileImage == null) {
      dialog(
        context,
        title: "Insira uma imagem de perfil!",
        body: "Por favor, clique no ícone de perfil e insira uma imagem.",
      );
      return;
    }

    try {
      var data = await http.post(
        API_URL + '/updateProfile',
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer " + prefs.getString("token")
        },
        body: jsonEncode({
          "cep": cepUpdateController.text.trim(),
          "address": endUpdateController.text,
          "house_number": numeroUpdateController.text.trim(),
          "reference": refUpdateController.text,
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
          "profile_picture": linkImg != null ? linkImg : null
        }),
      );

      isLoading(context, false);

      print(data.body);

      switch (data.statusCode) {
        case 200:
        case 204:
          dialog(context,
              title: "Atualizado com sucesso!",
              body: "Suas informações foram atualizadas.");
          break;
        default:
          dialog(
            context,
            title: "Ocorreu um erro! - " + data.statusCode.toString(),
            body: "Ocorreu um erro ao tentar atualizar seus dados.",
          );
      }
    } catch (e) {
      print(e);
    }
  }

  @observable
  String cep = "";

  @observable
  var errortextCep = "";

  @action
  Future<dynamic> newCep(String value) async {
    cep = value;

    if (cep.length > 1 && cep.length < 8) {
      errortextCep = "CEP tem que ter 8 caracteres";
    } else {
      errortextCep = "";
      var endereco = await http.get(
          "http://www.cepaberto.com/api/v3/cep?cep=" + cep.trim(),
          headers: {
            'Authorization': 'Token token=471dec71c96f8dbc684056839dc3411b'
          });
      var data = jsonDecode(endereco.body);
      if (data["latitude"] != null && data["longitude"] != null) {
        latitude = data["latitude"];
        longitude = data["longitude"];
      } else {
        var location = new Location();
        var userLocation = await location.getLocation();
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
      }
      endUpdateController.text = data["logradouro"] +
          " - " +
          data["bairro"] +
          " - " +
          data["cidade"]["nome"] +
          "-" +
          data["estado"]["sigla"];
      refUpdateController.text = data["complemento"];
    }
  }
}
