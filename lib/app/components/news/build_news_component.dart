import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/news/card_counter_disease_component.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BuildNews extends StatelessWidget {
  final AsyncSnapshot snapshot;
  BuildNews(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data[0]["articles"].length,
      itemBuilder: (context, index) {
        var descricao = snapshot.data[0]["articles"][index]["description"];

        if (descricao.length > 110) {
          descricao = descricao.substring(0, 110) + "...";
        } else if (descricao == "" || descricao == null) {
          descricao = snapshot.data[0]["articles"][index]["title"];
        }

        if (index == 0) {
          return CardCases();
        } else {
          return _cardNews(snapshot, index, descricao);
        }
      },
    );
  }

  Future<bool> checkUrl(String url) async {
    try {
      var statusCode = await http.get(url);

      if (statusCode.statusCode == 200 || statusCode.statusCode == 204) {
        return true;
      }

      return false;
    } catch (e) {
      return null;
    }
  }

  Widget _cardNews(AsyncSnapshot snapshot, int index, String descricao) {
    var image = snapshot.data[0]["articles"][index]["urlToImage"];
    return GestureDetector(
      onTap: () async {
        await launch(snapshot.data[0]["articles"][index]["url"],
            forceWebView: true, enableJavaScript: true);
      },
      child: SizedBox(
        height: 110,
        child: Card(
          elevation: 0.0,
          margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: Row(
            children: <Widget>[
              FutureBuilder(
                future:
                    checkUrl(snapshot.data[0]["articles"][index]["urlToImage"]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none) {
                    return Container(
                      width: 150.0,
                      height: 100.0,
                      color: Colors.grey,
                      child: Icon(Icons.image),
                    );
                  } else {
                    if (snapshot.data) {
                      return ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                          child: Image.network(
                            image,
                            width: 150.0,
                            height: 100.0,
                            fit: BoxFit.fill,
                          ));
                    } else {
                      return Container(
                        width: 150.0,
                        height: 100.0,
                        color: Colors.grey,
                        child: Icon(Icons.image),
                      );
                    }
                  }
                },
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
