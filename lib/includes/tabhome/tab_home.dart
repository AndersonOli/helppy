import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/widgets/card_idoso.dart';
import 'package:helppyapp/widgets/card_voluntario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:helppyapp/widgets/suports_widgets.dart';

class HomeTab extends StatefulWidget {
    @override
    _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
    Future _futureList;
    var token, idUser, typeACC;
    var prefs, lat, long, responseDistance;

    @override
    void initState() {
        super.initState();
        setValue();
        _futureList = getResponseList();
    }

    Future<void> setValue() async {
        prefs = await SharedPreferences.getInstance();
        token = prefs.getString('token');
        idUser = prefs.getInt('user_id');
        typeACC = prefs.getString('type_acc');
    }

    Future<void> requestDistance() async {
        final token = prefs.getString('token');
        final response = await http.post(
            'https://helppy-19.herokuapp.com/distance',
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            body: <String, String>{
                "lat": lat.toString(),
                "long": long.toString()
            }
        );
        responseDistance = json.decode(response.body);
    }

    Future<void> getCords() async {
        var location = new Location();
        var userLocation = await location.getLocation();
        lat = userLocation.latitude;
        long = userLocation.longitude;
    }

    Future<List> getResponseList() async {
        var response;

        if(typeACC == "1"){
            response = await http.get(
                'https://helppy-19.herokuapp.com/list/$idUser',
                headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            );
            return json.decode(response.body);
        } else {
            await getCords();
            response = await http.post(
                'https://helppy-19.herokuapp.com/accept',
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

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    Expanded(
                        child: FutureBuilder(
                            initialData: "Carregando...",
                            future: _futureList,
                            builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                    return loadingCenter();
                                } else {
                                    final _width = MediaQuery.of(context).size.width;
                                    final _height = MediaQuery.of(context).size.height;

                                    if(snapshot.data == null){
                                        return Container(
                                            child: Center(
                                                child: Text(
                                                    prefs.getString('type_acc') == "0" ? "Não há pedidos para ajudar no momento." : "Você ainda não fez nenhum pedido. Se precisa de ajuda, clique no botão com o + abaixo..",
                                                    style: TextStyle(
                                                        color: COR_AZUL,
                                                        fontSize: 18.0,
                                                    ),
                                                ),
                                            ),
                                        );
                                    }

                                    return snapshot.data.length > 0 ? SingleChildScrollView(
                                        child: Container(
                                            width: _width,
                                            height: _height,
                                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                            child: RefreshIndicator(
                                                onRefresh: () async {
                                                    setState(() {});
                                                },
                                                child: ListView.builder(
                                                    itemCount: snapshot.data.length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index){
                                                        return prefs.getString('type_acc') == "0" ? cardPedidoVoluntario(context, snapshot, index, responseDistance) : cardPedidoIdoso(context, snapshot, index, prefs);
                                                    },
                                                ),
                                            ),
                                        ),
                                    ) : Center(
                                        child: Text(
                                            prefs.getString('type_acc') == "0" ? "Não há pedidos para ajudar no momento." : "Você ainda não fez nenhum pedido. Se precisa de ajuda, clique no botão com o + abaixo..",
                                            style: TextStyle(
                                                color: COR_AZUL,
                                                fontSize: 18.0,
                                            ),
                                        ),
                                    );
                                }
                            }
                        ),
                    ),
                ],
            ),
        );
    }
}



