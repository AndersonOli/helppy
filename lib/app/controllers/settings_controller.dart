import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import '../components/general/globals_component.dart';
part 'settings_controller.g.dart';

class SettingsController = _SettingsController with _$SettingsController;

abstract class _SettingsController with Store {
  @observable
  var fileProfileImage;

  @action
  void changeProfileImage(dynamic value) => fileProfileImage = value;

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

  var latitude, longitude;
  final TextEditingController emailUpdateController = TextEditingController();
  final TextEditingController telUpdateController = TextEditingController();
  final TextEditingController cepUpdateController = TextEditingController();
  final TextEditingController endUpdateController = TextEditingController();
  final TextEditingController numeroUpdateController = TextEditingController();
  final TextEditingController refUpdateController = TextEditingController();

  @action
  Future<void> update() async {
    http.Response data = await http.post(
      API_URL + '/updateProfile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "cep": cepUpdateController.text.trim(),
        "address": endUpdateController.text,
        "house_number": numeroUpdateController.text.trim(),
        "reference": refUpdateController.text,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "profile_picture": base64Encode(fileProfileImage.readAsBytesSync())
      }),
    );

    print(data.body);
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
          headers: {'Authorization': 'Token token=471dec71c96f8dbc684056839dc3411b'}
      );
      var data = jsonDecode(endereco.body);
      print(data);
      if(data["latitude"] != null && data["longitude"] != null){
        latitude = data["latitude"];
        longitude = data["longitude"];
      } else {
        var location = new Location();
        var userLocation = await location.getLocation();
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
      }
      endUpdateController.text = data["logradouro"] + " - " + data["bairro"] + " - " + data["cidade"]["nome"] + "-" + data["estado"]["sigla"];
      refUpdateController.text = data["complemento"];
    }
  }
}