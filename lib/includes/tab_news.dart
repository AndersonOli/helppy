import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class NewsTab extends StatefulWidget {
    @override
    _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
    String textCard(String dataUpdate, String casesBr, String casesLocal){
        return 'Última atualização: $dataUpdate\n\n' +
            'Teresina - Piauí\n' +
            '\t\t\t\tCasos confirmados: $casesLocal\n' +
            'Brazil\n' +
            '\t\t\t\tCasos confirmados: $casesBr';
    }

    apiData() async {
        var response = await http.get('http://newsapi.org/v2/everything?q=coronavirus&?country=br&apiKey=3aaaaf0e6ab44bdea5e9806c43ee6447');
        var responseCorona = await http.get('https://especiais.g1.globo.com/bemestar/coronavirus/mapa-coronavirus/data/brazil-cases.json');
        return [convert.jsonDecode(response.body), convert.jsonDecode(responseCorona.body)];
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    Expanded(
                        child: FutureBuilder(
                            future: apiData(),
                            builder: (context, snapshot){
                                switch(snapshot.connectionState){
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                        return Center(
                                            child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(azulStd),
                                                strokeWidth: 5.0,
                                            ),
                                        );
                                    case ConnectionState.done:
                                        return _buildNews(context, snapshot);
                                        break;
                                    default:
                                        if(snapshot.hasError){
                                            return Container();
                                        } else {
                                            return _buildNews(context, snapshot);
                                        }
                                }
                            }
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildNews(BuildContext context, AsyncSnapshot snapshot){
        return ListView.builder(
            itemCount: snapshot.data[0]["articles"].length,
            itemBuilder: (context, index){
                if(snapshot.data[0]["articles"][index]["description"].length > 110){
                    snapshot.data[0]["articles"][index]["description"] = snapshot.data[0]["articles"][index]["description"].substring(0, 110) + "...";
                }
                if(index == 0){
                    return LimitedBox(
                        maxHeight: 270,
                        child: Card(
                            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            color: azulStd,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                    Divider(),
                                    Text("Dados do coronavírus",
                                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                                        textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                            textCard(
                                                snapshot.data[1]["updated_at"].substring(0, 10) + " às " +
                                                snapshot.data[1]["updated_at"].substring(16),
                                                "000", "000"
                                            ),
                                            style: TextStyle(color: brancoStd, fontSize: 16.0),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    );
                } else if(index == snapshot.data[0]["articles"].length-1){
                    return Column(
                        children: <Widget>[
                            GestureDetector(
                                onTap: () async {
                                    await launch(snapshot.data[0]["articles"][index]["url"]);
                                },
                                child: SizedBox(
                                    height: 100,
                                    child: Card(
                                        margin: EdgeInsets.only(top: 15.0),
                                        child: Row(
                                            children: <Widget>[
                                                ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(4),
                                                        bottomLeft: Radius.circular(4),
                                                    ),
                                                    child: Image.network(
                                                        snapshot.data[0]["articles"][index]["urlToImage"],
                                                        width: 150.0,
                                                        height: 100.0,
                                                        fit: BoxFit.fill,
                                                    ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                        child: Text(snapshot.data[0]["articles"][index]["description"],
                                                            textAlign: TextAlign.justify,),
                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                            SizedBox(
                                height: 53,
                            )
                        ],
                    );
                } else {
                    return GestureDetector(
                        onTap: () async {
                            await launch(snapshot.data[0]["articles"][index]["url"]);
                        },
                        child: SizedBox(
                            height: 100,
                            child: Card(
                                margin: EdgeInsets.only(top: 15.0),
                                child: Row(
                                    children: <Widget>[
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                            ),
                                            child: Image.network(
                                                snapshot.data[0]["articles"][index]["urlToImage"],
                                                width: 150.0,
                                                height: 100.0,
                                                fit: BoxFit.fill,
                                            ),
                                        ),
                                        Expanded(
                                            child: Container(
                                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: Text(snapshot.data[0]["articles"][index]["description"],
                                                    textAlign: TextAlign.justify,),
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        ),
                    );
                }
            },
        );
    }
}

