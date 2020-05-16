import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:helppyapp/includes/general/pages.dart';
import 'package:helppyapp/includes/general/globals.dart';

class BuildNews extends StatelessWidget {
    final AsyncSnapshot snapshot;
    BuildNews(this.snapshot);

    String countCasesTeresina(List api) {
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

    String countCasesBrasil(List api) {
        int cases = 0;
        for (var item in api) {
            if(item["cases"] is int){
                cases += item['cases'];
            }
        }
        return cases.toString();
    }

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: snapshot.data[0]["articles"].length,
            itemBuilder: (context, index) {
                var descricao = snapshot.data[0]["articles"][index]["description"];

                if (descricao.length > 110) {
                    descricao = descricao.substring(0, 110) + "...";
                } else if(descricao == "" || descricao == null) {
                    descricao = snapshot.data[0]["articles"][index]["title"];
                }

                if (index == 0) {
                    return _cardCases(snapshot);
                } else {
                    return _cardNews(snapshot, index, descricao);
                }
            },
        );
    }

    Widget _cardCases(AsyncSnapshot snapshot) {
        return Container(
            child: Card(
                margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
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
    }


    Widget _cardNews(AsyncSnapshot snapshot, int index, String descricao) {
        return GestureDetector(
            onTap: () async {
                await launch(snapshot.data[0]["articles"][index]["url"], forceWebView: true, enableJavaScript: true);
            },
            child: SizedBox(
                height: 110,
                child: Card(
                    elevation: 0.0,
                    margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
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
                                        descricao,
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
}