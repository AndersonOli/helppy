import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class NewsTab extends StatefulWidget {
    @override
    _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
    String textosNoticia =
        'Última atualização: 00/00/0000 às 00:00\n\n' +
        'Teresina - Piauí\n' +
        '\t\t\t\tCasos confirmados: 000\n' +
        'Brazil\n' +
        '\t\t\t\tCasos confirmados: 000';

    var url = 'http://newsapi.org/v2/everything?q=coronavirus&?country=br&apiKey=3aaaaf0e6ab44bdea5e9806c43ee6447';

    Future newsData() async {
        var response = await http.get(url);
        return convert.jsonDecode(response.body);
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    Column(
                        children: <Widget>[
                            LimitedBox(
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
                                                child: Text(textosNoticia, style: TextStyle(color: brancoStd, fontSize: 16.0),),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Expanded(
                        child: FutureBuilder(
                            future: newsData(),
                            builder: (context, snapshot){
                                switch(snapshot.connectionState){
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                        return Container(
                                            width: 200.0,
                                            height: 200.0,
                                            alignment: Alignment.center,
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
            itemCount: snapshot.data["articles"].length,
            itemBuilder: (context, index){
                if(snapshot.data["articles"][index]["description"].length > 110){
                    snapshot.data["articles"][index]["description"] = snapshot.data["articles"][index]["description"].substring(0, 110) + "...";
                }
                return GestureDetector(
                    onTap: (){},
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
                                            snapshot.data["articles"][index]["urlToImage"],
                                            width: 150.0,
                                            height: 100.0,
                                            fit: BoxFit.fill,
                                        ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                            child: Text(snapshot.data["articles"][index]["description"],
                                                textAlign: TextAlign.justify,),
                                        ),
                                    )
                                ],
                            ),
                        ),
                    ),
                );
            },
        );
    }
}

