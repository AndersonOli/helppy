import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/controllers/controllerTab.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'controllerTabHome.g.dart';

class ControllerTabHome = _ControllerTabHome with _$ControllerTabHome;

abstract class _ControllerTabHome with Store {
    Map preferences;
    var lat, long, responseDistance;

    Future<void> getCords() async {
        var location = new Location();
        var userLocation = await location.getLocation();
        lat = userLocation.latitude;
        long = userLocation.longitude;
    }

    Future<void> requestDistance(Map preferences) async {
        final response = await http.post(
            API_URL + '/distance',
            headers: {HttpHeaders.authorizationHeader: "Bearer " + preferences['token']},
            body: <String, String>{
                "lat": lat.toString(),
                "long": long.toString()
            }
        );
        responseDistance = json.decode(response.body);
    }

    Future getResponseList(HomeController controller) async {
        var response;
        preferences = await controller.getPreferences();

        if(preferences['type_acc'] == "1"){
            response = await http.get(
                API_URL + '/list/' + preferences['user_id'].toString(),
                headers: {HttpHeaders.authorizationHeader: "Bearer " + preferences['token']},
            );
            return json.decode(response.body);
        } else {
            await getCords();
            response = await http.post(
                API_URL + '/accept',
                headers: {HttpHeaders.authorizationHeader: "Bearer " + preferences['token']},
                body: {
                    "lat": lat.toString(),
                    "long": long.toString()
                },
            );
            await requestDistance(preferences);
            return json.decode(response.body);
        }
    }

    @observable
    Future<dynamic> futureData;

    @action
    getResult(HomeController controller){
        futureData = getResponseList(controller);
    }
}