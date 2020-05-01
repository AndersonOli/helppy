import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/view_list.dart';
import 'package:helppyapp/ui/control_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:helppyapp/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
    @override
    _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
    var prefs;

    getResponseList() async {
        prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        final idUser = prefs.getInt('user_id');
        final typeACC = prefs.getString('type_acc');
        final response = await http.get(
            typeACC == "1" ? 'https://helppy-19.herokuapp.com/list/$idUser' : 'https://helppy-19.herokuapp.com/list',
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        );
        return json.decode(response.body);
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
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                        return prefs.getString('type_acc') == "0" ? _cardPedidoVoluntario(context, snapshot, index) : _cardPedidoIdoso(context, snapshot, index);
                    },
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
                color: COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
                children: <Widget>[
                    Container(
                        width: _width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                            snapshot.data[index]["title"],
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
                            "Aceito por: " + "Seu pedido ainda não foi aceito..",
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
                            "Pedido feito em " + snapshot.data[index]["created_at"].substring(0, 10).replaceAll("-", "/"),
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
                                SizedBox(
                                    width: 10.0,
                                ),
                                Expanded(
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
                                                title: Text("Você está prestes a cancelar este pedido!"),
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
                                            "Cancelar".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                )
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
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    child: OutlineButton(
                                        onPressed: (){},
                                        borderSide: BorderSide(color: COR_BRANCO),
                                        child: Text(
                                            "Ver pedido".toUpperCase(),
                                            style: TextStyle(
                                                color: COR_BRANCO,
                                                fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ),
                                SizedBox(
                                    width: 10.0,
                                ),
                                Expanded(
                                    child: OutlineButton(
                                        onPressed: (){},
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
                                )
                            ],
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text(
                                    "Em " + snapshot.data[index]["updated_at"].substring(0, 10).replaceAll("-", "/"),
                                    style: TextStyle(
                                        color: COR_BRANCO,
                                        fontSize: 14.0,
                                    ),
                                ),
                                Row(
                                    children: <Widget>[
                                        Icon(Icons.location_on, size: 14.0, color: COR_BRANCO,),
                                        Text(
                                            "200m",
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
}



