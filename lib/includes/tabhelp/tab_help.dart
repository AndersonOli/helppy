import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/tabhelp/lista_videos.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'lista_dicas.dart';

class HelpTab extends StatefulWidget {
    @override
    _HelpTabState createState() => _HelpTabState();
}

class _HelpTabState extends State<HelpTab> with AutomaticKeepAliveClientMixin<HelpTab> {
    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            body: FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 1200)),
                builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return loadingCenter();
                    } else {
                        return new ListView.builder(
                            itemCount: dicas.length,
                            itemBuilder: (context, index) {
                                return Column(
                                    children: <Widget>[
                                        index == 0 ? new Padding(
                                            padding:
                                            new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                            child: new Card(
                                                elevation: 0.0,
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
                                                elevation: 0.0,
                                                color: COR_AZUL,
                                                shape: new RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(16.0)),
                                                child: new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                        new ClipRRect(
                                                            child: new Image.asset(dicas[index].imageUrl),
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
                                    ],
                                );
                            });
                    }
                },
            ),
        );
    }

    @override
    bool get wantKeepAlive => true;
}
