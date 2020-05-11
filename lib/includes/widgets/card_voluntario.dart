import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/tabhome/aceitar_pedido.dart';
import 'card_idoso.dart';

String valueDistance(AsyncSnapshot snapshot, int index, responseDistance) {
    var id = snapshot.data[index]["user_id"];
    var viewDistance;

    for (var i in responseDistance){
        if (id == i["id"]){
            viewDistance = i['distance'];
        }
    }
    return viewDistance.toString();
}

Widget cardPedidoVoluntario(BuildContext context, AsyncSnapshot snapshot, int index, dynamic responseDistance){
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
                                        "≈" + valueDistance(snapshot, index, responseDistance) + "m",
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