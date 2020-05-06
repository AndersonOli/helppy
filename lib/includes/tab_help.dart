import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';
import 'package:helppyapp/includes/tabhelp/lista_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'tabhelp/lista_dicas.dart';

class HelpTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
//            appBar: AppBar(
//                centerTitle: true,
//                backgroundColor: COR_AZUL,
//                title: Text(
//                    'Dicas de Higienização',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        fontSize: 18,
//                        color: Colors.white,
//                    ),
//                ),
//                elevation: 0.0,
//                actions: <Widget>[
//                    IconButton(
//                        icon: Icon(Icons.movie),
//                        color: Colors.white,
//                        onPressed: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => TelaVideo()),
//                            );
//                        } //Receber tela de vídeo
//                    )
//                ],
//            ),
            body: new ListView.builder(
                itemCount: dicas.length,
                itemBuilder: (context, index) {
                    return Column(
                        children: <Widget>[
                            index == 0 ? new Padding(
                                padding:
                                new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: new Card(
                                    elevation: 12.0,
                                    color: COR_AZUL,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(16.0)),
                                    child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            new ClipRRect(
                                                child: YoutubePlayer(
                                                    controller: YoutubePlayerController(
                                                        initialVideoId: YoutubePlayer.convertUrlToId(
                                                            videos[index].videoUrl),
                                                        flags: YoutubePlayerFlags(autoPlay: false)),
                                                    showVideoProgressIndicator: true,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: new Radius.circular(16.0),
                                                    topRight: new Radius.circular(16.0),
                                                ),
                                            ),
                                            new Padding(
                                                padding: new EdgeInsets.all(10.0),
                                                child: new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                        new Text(
                                                            videos[index].title,
                                                            style: TextStyle(color: COR_BRANCO, fontSize: 18.0),
                                                        ),
                                                        new SizedBox(height: 12.0),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ) :  Container(width: 0.0, height: 0.0,),
                            new Padding(
                                padding:
                                new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: new Card(
                                    elevation: 4.0,
                                    color: COR_AZUL,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(16.0)),
                                    child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            new ClipRRect(
                                                child: new Image.network(dicas[index].imageUrl),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: new Radius.circular(16.0),
                                                    topRight: new Radius.circular(16.0),
                                                ),
                                            ),
                                            new Padding(
                                                padding: new EdgeInsets.all(16.0),
                                                child: new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                        new Text(
                                                            dicas[index].title,
                                                            style: TextStyle(color: COR_BRANCO, fontSize: 18.0),
                                                        ),
                                                        new SizedBox(height: 16.0),
                                                        new Row(
                                                            children: <Widget>[
                                                                Flexible(
                                                                    child: new Text(
                                                                        dicas[index].text,
                                                                        style:
                                                                        TextStyle(
                                                                            color: COR_BRANCO,
                                                                            fontSize: 16.0
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            index == dicas.length-1 ? SizedBox(height: 55.0,) : Container(width: 0.0, height: 0.0,)
                        ],
                    );
                }),
        );
    }
}