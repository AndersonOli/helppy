import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:helppyapp/includes/general/pages.dart';
import 'package:helppyapp/includes/general/globals.dart';

List<String> textCard(String dataUpdate, String casesBr, String casesLocal) {
    return [
        'Última atualização: $dataUpdate\n',
        '\t\t\t\tCasos confirmados: $casesLocal\n',
        '\t\t\t\tCasos confirmados: $casesBr'
    ];
}

apiData() async {
    var response = await http.get('http://newsapi.org/v2/everything?language=pt&q=coronavirus brazil&?country=br&apiKey=3aaaaf0e6ab44bdea5e9806c43ee6447');
    var responseCorona = await http.get('https://api.especiaisg1.globo/api/eventos/brasil/?format=json');

    return [
        convert.jsonDecode(response.body),
        convert.jsonDecode(responseCorona.body)
    ];
}

countCasesTeresina(List api) {
    int cases = 0;
    for (var item in api) {
        if (item['city_cod'] == 2211001) {
            if(item["cases"] is int){
                cases += item['cases'];
            }
        }
    }
    return cases.toString();
}

countCasesBrasil(List api) {
    int cases = 0;
    for (var item in api) {
        if(item["cases"] is int){
            cases += item['cases'];
        }
    }
    return cases.toString();
}

Widget buildNews(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data[0]["articles"].length,
        itemBuilder: (context, index) {
            if (snapshot.data[0]["articles"][index]["description"].length > 110) {
                snapshot.data[0]["articles"][index]["description"] = snapshot.data[0]["articles"][index]["description"].substring(0, 110) + "...";
            } else if (snapshot.data[0]["articles"][index]["description"] == "" ||
                snapshot.data[0]["articles"][index]["description"] == null) {
                snapshot.data[0]["articles"][index]["description"] = snapshot.data[0]["articles"][index]["title"];
            }
            if (index == 0) {
                return Container(
                    child: Card(
                        margin: EdgeInsets.only(top: 20.0),
                        color: COR_AZUL,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                                SizedBox(height: 15.0,),
                                Text(
                                    "Número de casos do coronavírus",
                                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                                    textAlign: TextAlign.center,
                                ),
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                        children: <Widget>[
                                            Container(
                                                child: Text(
                                                    "Última atualização: " +
                                                        snapshot.data[1]["updated_at"].substring(0, 10) + " às " +
                                                        snapshot.data[1]["updated_at"].substring(16) + "\n",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(color: COR_BRANCO, fontSize: 18.0),
                                                ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(bottom: 10.0),
                                                child: Row(
                                                    children: <Widget>[
                                                        Expanded(
                                                            child: RichText(
                                                                textAlign: TextAlign.center,
                                                                text: TextSpan(
                                                                    text: "Teresina - Piauí",
                                                                    style: TextStyle(
                                                                        color: COR_BRANCO,
                                                                        fontSize: 16.0,
                                                                        fontFamily: 'Nunito'
                                                                    ),
                                                                    children: [
                                                                        TextSpan(
                                                                            text: "\n\n" + countCasesTeresina(snapshot.data[1]['docs'])
                                                                        ),
                                                                    ]
                                                                ),
                                                            ),
                                                        ),
                                                        Expanded(
                                                            child: RichText(
                                                                textAlign: TextAlign.center,
                                                                text: TextSpan(
                                                                    text: "Brasil",
                                                                    style: TextStyle(
                                                                        color: COR_BRANCO,
                                                                        fontSize: 16.0,
                                                                    ),
                                                                    children: [
                                                                        TextSpan(
                                                                            text: "\n\n" + countCasesBrasil(snapshot.data[1]['docs'])
                                                                        ),
                                                                    ]
                                                                ),
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ),
                );
            } else {
                return GestureDetector(
                    onTap: () async {
                        await launch(snapshot.data[0]["articles"][index]["url"], forceWebView: true, enableJavaScript: true);
                    },
                    child: SizedBox(
                        height: 110,
                        child: Card(
                            margin: EdgeInsets.only(top: 12.0),
                            child: Row(
                                children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                        ),
                                        child: Image.network(
                                            snapshot.data[0]["articles"][index]["urlToImage"] ??
                                                "https://www.coronavirus.ms.gov.br/wp-content/uploads/2020/04/coronavirus-1.jpg",
                                            width: 150.0,
                                            height: 100.0,
                                            fit: BoxFit.fill,
                                        ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                            child: Text(
                                                snapshot.data[0]["articles"][index]["description"],
                                                textAlign: TextAlign.justify,
                                            ),
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