import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/view_list.dart';
import 'package:helppyapp/ui/control_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/globals.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'aceitar_pedido.dart';

class HomeTab extends StatefulWidget {
    @override
    _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
    var prefs, lat, long, responseDistance;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        setValue();
    }

    setValue() async {
        prefs = await SharedPreferences.getInstance();
    }

    requestDistance() async {
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

    getResponseList() async {
        await requestPermission();
        final token = prefs.getString('token');
        final idUser = prefs.getInt('user_id');
        final typeACC = prefs.getString('type_acc');
        var response;

        if(typeACC == "1"){
            response = await http.get(
                'https://helppy-19.herokuapp.com/list/$idUser',
                headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            );
            return json.decode(response.body);
        } else {
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

    Future<void> requestPermission() async {
        final PermissionHandler _permissionHandler = PermissionHandler();
        var result = await _permissionHandler.checkPermissionStatus(PermissionGroup.locationWhenInUse);

        switch (result) {
            case PermissionStatus.granted:
                var geolocator = Geolocator();
                Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

                lat = position.latitude;
                long = position.longitude;
                break;
            case PermissionStatus.denied:
                await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
                requestPermission();
                break;
            default:
                await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);
                requestPermission();
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
                            future: getResponseList(),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                        return Center(
                                            child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
                                                strokeWidth: 5.0,
                                            ),
                                        );
                                    case ConnectionState.done:
                                        return _listCard(context, snapshot);
                                        break;
                                    default:
                                        if (snapshot.hasError) {
                                            return Container();
                                        } else {
                                            return _listCard(context, snapshot);
                                        }
                                }
                            }),
                    ),
                ],
            ),
        );
    }

    Widget _listCard(BuildContext context, AsyncSnapshot snapshot) {
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;

        return snapshot.data.length > 0 ? SingleChildScrollView(
            child: Container(
                width: _width,
                height: _height,
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: RefreshIndicator(
                    onRefresh: () async {
                        setState(() {

                        });
                    },
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                            return prefs.getString('type_acc') == "0" ? _cardPedidoVoluntario(context, snapshot, index) : _cardPedidoIdoso(context, snapshot, index);
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

    Widget _cardPedidoIdoso(BuildContext context, AsyncSnapshot snapshot, int index){
        final _width = MediaQuery.of(context).size.width;

        return Container(
            width: _width,
            margin: index == (snapshot.data.length - 1) ? EdgeInsets.only(top: 15.0, bottom: 75.0) : EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
                color: snapshot.data[index]["status"] == "2" ? Color.fromRGBO(8, 77, 110, 1.0) : COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
                children: <Widget>[
                    Container(
                        width: _width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                            snapshot.data[index]["status"] == "2" ? snapshot.data[index]["title"] + "(Finalizado)" : snapshot.data[index]["title"]  + "(Em andamento)",
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Descrição: " + snapshot.data[index]["description"],
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0, bottom: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            statusRequest(snapshot, index),
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Pedido feito em " + replaceDate(snapshot, index),
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: OutlineButton(
                                        onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                    return ViewList(transformStringInList(snapshot, index));
                                                },
                                            ));
                                        },
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            "Ver lista".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ),
                                snapshot.data[index]["status"] == "0" || snapshot.data[index]["status"] == "2" ? SizedBox(
                                    width: 10.0,
                                ) : Container(),
                                snapshot.data[index]["status"] == "0" || snapshot.data[index]["status"] == "2" ? Expanded(
                                    child: OutlineButton(
                                        onPressed: (){
                                            Widget cancel = FlatButton(
                                                child: Text("Cancelar"),
                                                onPressed: () {
                                                    Navigator.of(context).pop();
                                                },
                                            );

                                            Widget delete = FlatButton(
                                                child: Text("Sim"),
                                                onPressed: () async {
                                                    http.Response data = await http.delete(
                                                        'https://helppy-19.herokuapp.com/list/' + snapshot.data[index]["id"].toString(),
                                                        headers: {
                                                            "Content-Type": "application/json; charset=utf-8",
                                                            HttpHeaders.authorizationHeader: "Bearer " + prefs.getString('token')
                                                        },
                                                    );

                                                    if(data.statusCode == 200){
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context){
                                                                return ControlPage(true);
                                                            },
                                                        ));
                                                    } else {
                                                        Navigator.of(context).pop();
                                                        showAlertDialog(context, "Ocorreu um erro :(", "Algo deu errado, não foi possível cancelar seu pedido neste momento, tente novamente mais tarde.");
                                                    }
                                                },
                                            );
                                            AlertDialog alerta = AlertDialog(
                                                title: Text(snapshot.data[index]["status"] == "2" ? "Você está prestes a apagar este pedido do seu histórico!" : "Você está prestes a cancelar este pedido!"),
                                                content: Text("Essa ação não pode ser desfita, tem certeza?"),
                                                actions: [
                                                    cancel,
                                                    delete,
                                                ],
                                            );
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                    return alerta;
                                                },
                                            );
                                        },
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            snapshot.data[index]["status"] == "2" ? "Apagar".toUpperCase() : "Cancelar".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ) : Container()
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    Widget _cardPedidoVoluntario(BuildContext context, AsyncSnapshot snapshot, int index){
        final _width = MediaQuery.of(context).size.width;
        return Container(
            width: _width,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10.0, left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Pedido de " + snapshot.data[index]["full_name"],
                            style: TextStyle(
                                color: COR_BRANCO,
                                fontSize: 18.0,
                            ),
                        ),
                    ),
                    Container(
                        width: _width,
                        margin: EdgeInsets.all(10.0),
                        child: OutlineButton(
                            onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context){
                                        return AcceptRequest(snapshot.data[index]);
                                    },
                                ));
                            },
                            borderSide: BorderSide(color: COR_BRANCO),
                            child: Text(
                                "Aceitar pedido".toUpperCase(),
                                style: TextStyle(
                                    color: COR_BRANCO,
                                    fontSize: 14.0,
                                ),
                                textAlign: TextAlign.center,
                            ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text(
                                    "Em " + replaceDate(snapshot, index),

                                    style: TextStyle(
                                        color: COR_BRANCO,
                                        fontSize: 14.0,
                                    ),
                                ),
                                Row(
                                    children: <Widget>[
                                        Icon(Icons.location_on, size: 14.0, color: COR_BRANCO,),
                                        Text(
                                            valueDistance(snapshot, index) + "m",
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                        )
                                    ],
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }


    transformStringInList(AsyncSnapshot snapshot, int index) {
        String buildText = '';
        List list = [];
        var response = snapshot.data[index];

        String replaceString = response['shoppings']
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "");

        for (var i = 0; i < replaceString.length; i++) {
            if(replaceString[i] != ',') {
                buildText += replaceString[i];
            }

            if((i == (replaceString.length - 1)) || (replaceString[i] == ',')) {
                list.add(buildText);
                buildText = '';
            }
        }
        return list;
    }

    String valueDistance(AsyncSnapshot snapshot, int index) {
        var id = snapshot.data[index]["user_id"];
        var viewDistance;

        for (var i in responseDistance){
            if (id == i["id"]){
                viewDistance = i['distance'];
            }
        }
        return viewDistance.toString();
    }

    String replaceDate(AsyncSnapshot snapshot, int index) {
        String buildText = '';
        List list = [];

        var responseString = snapshot.data[index]["created_at"].substring(0, 10);

        for (var i = 0; i < responseString.length; i++) {
            if(responseString[i] != '-') {
                buildText += responseString[i];
            }

            if((i == (responseString.length - 1)) || (responseString[i] == '-')) {
                list.add(buildText);
                buildText = '';
            }
        }

        String replaceString =  list[2].toString() + '/' + list[1].toString() + '/' + list[0].toString();

        return replaceString;
    }

    String statusRequest(AsyncSnapshot snapshot, int index){
        switch(snapshot.data[index]["status"]){
            case "1":
                return "Aceito por: " + snapshot.data[index]["accept_by"];
                break;
            case "2":
                return "Seu pedido foi aceito e finalizado por: " + snapshot.data[index]["accept_by"];
                break;
            default:
                return "Seu pedido ainda não foi aceito..";
        }
    }
}



