import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/tabhome/aceitar_pedido.dart';

class CardVoluntario extends StatelessWidget {
    final AsyncSnapshot snapshot;
    final int index;
    final dynamic responseDistance;

    CardVoluntario({@required this.snapshot, @required this.index, @required this.responseDistance});

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

    @override
    Widget build(BuildContext context) {
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
}
