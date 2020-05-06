import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../globals.dart';
import 'lista_videos.dart';

class TelaVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: COR_AZUL,
        title: Text("Dicas em vídeos"),
      ),
      body: new ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return new Padding(
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
            );
          }),
    );
  }
}
