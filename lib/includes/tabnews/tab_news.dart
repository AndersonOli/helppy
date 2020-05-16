import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/widgets/build_news.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class NewsTab extends StatefulWidget {
    @override
    _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with AutomaticKeepAliveClientMixin<NewsTab> {
    Future _futureData;

    @override
    void initState() {
        super.initState();
        _futureData = apiData();
    }

    apiData() async {
        var response = await http.get('http://newsapi.org/v2/everything?language=pt&q=coronavirus brazil&?country=br&apiKey=3aaaaf0e6ab44bdea5e9806c43ee6447');
        var responseCorona = await http.get('https://api.especiaisg1.globo/api/eventos/brasil/?format=json');

        return [
            convert.jsonDecode(response.body),
            convert.jsonDecode(responseCorona.body)
        ];
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Column(
                children: <Widget>[
                    Expanded(
                        child: FutureBuilder(
                            future: _futureData,
                            builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                    return loadingCenter();
                                } else {
                                    if(snapshot.hasData){
                                        return BuildNews(snapshot);
                                    } else {
                                        return Center(
                                            child: Text(
                                                "Verifique sua conexão com a internet.",
                                                style: TextStyle(
                                                    color: COR_AZUL,
                                                    fontSize: 14.0
                                                ),
                                            ),
                                        );
                                    }
                                }
                            }),
                    ),
                ],
            ),
        );
    }

    @override
    bool get wantKeepAlive => true;
}