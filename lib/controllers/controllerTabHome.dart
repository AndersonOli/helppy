import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'controllerTabHome.g.dart';

class ControllerTabHome = _ControllerTabHome with _$ControllerTabHome;

abstract class _ControllerTabHome with Store {
    var token, idUser, typeACC;
    var lat, long, responseDistance;

    @observable
    var prefs;

    @action
    Future<void> setPreferences() async {
        prefs = await SharedPreferences.getInstance();
    }

    Future<void> getCords() async {
        var location = new Location();
        var userLocation = await location.getLocation();
        lat = userLocation.latitude;
        long = userLocation.longitude;
    }

    Future<void> requestDistance() async {
        final token = prefs.getString('token');
        final response = await http.post(
            API_URL + '/distance',
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            body: <String, String>{
                "lat": lat.toString(),
                "long": long.toString()
            }
        );
        responseDistance = json.decode(response.body);
    }

    Future getResponseList() async {
        var response;
        setPreferences();
        var prefs = await SharedPreferences.getInstance();
        token = prefs.getString('token');
        idUser = prefs.getInt('user_id');
        typeACC = prefs.getString('type_acc');

        if(typeACC == "1"){
            response = await http.get(
                API_URL + '/list/$idUser',
                headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            );
            return json.decode(response.body);
        } else {
            await getCords();
            response = await http.post(
                API_URL + '/accept',
                headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
                body: {
                    "lat": lat.toString(),
                    "long": long.toString()
                },
            );
            await requestDistance();
            return json.decode(response.body);
        }
    }

    @observable
    Future<dynamic> futureData;

    @action
    getResult(){
        futureData = getResponseList();
    }
}