import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CardCases extends StatefulWidget {
    @override
    _CardCasesState createState() => _CardCasesState();
}

class _CardCasesState extends State<CardCases> with AutomaticKeepAliveClientMixin<CardCases>  {
    Future casesData() async {
        var responseCorona = await http.get("https://api.especiaisg1.globo/api/eventos/brasil/?format=json");
        return convert.jsonDecode(responseCorona.body);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return FutureBuilder(
            future: casesData(),
            builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                        height: 220.0,
                        child: Card(
                            color: COR_AZUL,
                            margin: EdgeInsets.only(top: 15.0, bottom: 6.0),
                            child: loadingCenter(color: COR_BRANCO)
                        ),
                    );
                } else {
                    return Container(
                        height: 220.0,
                        alignment: Alignment.center,
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
                                                            snapshot.data["updated_at"].substring(0, 10) + " às " +
                                                            snapshot.data["updated_at"].substring(16) + "\n",
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
                                                                                text: "\n\n" + countCasesTeresina(snapshot.data['docs'])
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
                                                                                text: "\n\n" + countCasesBrasil(snapshot.data['docs'])
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
            },
        );
    }

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
        return (cases + 14550).toString(); //correção do cálculo com base na API
    }

    @override
    bool get wantKeepAlive => true;
}
