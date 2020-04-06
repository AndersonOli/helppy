import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';

class NewsTab extends StatefulWidget {
    @override
    _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
    String textosNoticia =
        'Última atualização: 30/30/3030 às 30:30\n\n' +
        'Teresina - Piauí\n' +
        '\t\t\t\tCasos confirmados: 100\n' +
        'Brazil\n' +
        '\t\t\t\tCasos confirmados: 1032';

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
                        child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: _buildNews
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildNews(BuildContext context, int index){
        if(index == 19){
            return Column(
                children: <Widget>[
                    GestureDetector(
                        onTap: (){},
                        child: SizedBox(
                            height: 100,
                            child: Card(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Row(
                                    children: <Widget>[
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                bottomLeft: Radius.circular(4.0),
                                            ),
                                            child: Image.network(
                                                "https://s2.glbimg.com/9Z8xUSj_yUjNB2aKad08hB8-iUg=/1200x/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_e84042ef78cb4708aeebdf1c68c6cbd6/internal_photos/bs/2020/k/f/ZQZAh6Sueplvam3fMcDw/bbb20-050420-232523.jpg",
                                                width: 150.0,
                                                height: 100.0,
                                                fit: BoxFit.fill,
                                            ),
                                        ),
                                        Expanded(
                                            child: Container(
                                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: Text("Gabi Martins foi eliminada do BBB (Big Brother Brasil) 20. Ela perdeu no paredão que disputava contra Thelma e Babu …",
                                                    textAlign: TextAlign.justify,),
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        ),
                    ),
                    SizedBox(
                        height: 52.0,
                    )
                ],
            );
        } else {
            return GestureDetector(
                onTap: (){},
                child: SizedBox(
                    height: 100,
                    child: Card(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                            children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                    ),
                                    child: Image.network(
                                        "https://s2.glbimg.com/9Z8xUSj_yUjNB2aKad08hB8-iUg=/1200x/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_e84042ef78cb4708aeebdf1c68c6cbd6/internal_photos/bs/2020/k/f/ZQZAh6Sueplvam3fMcDw/bbb20-050420-232523.jpg",
                                        width: 150.0,
                                        height: 100.0,
                                        fit: BoxFit.fill,
                                    ),
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Text("Gabi Martins foi eliminada do BBB (Big Brother Brasil) 20. Ela perdeu no paredão que disputava contra Thelma e Babu …",
                                            textAlign: TextAlign.justify,),
                                    ),
                                )
                            ],
                        ),
                    ),
                ),
            );
        }
    }
}

