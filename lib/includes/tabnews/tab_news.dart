import 'package:flutter/material.dart';
import 'package:helppyapp/includes/widgets/build_news.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';

class NewsTab extends StatefulWidget {
    @override
    _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    Expanded(
                        child: FutureBuilder(
                            future: apiData(),
                            builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                    return loadingCenter();
                                } else {
                                    return buildNews(context, snapshot);
                                }
                            }),
                    ),
                ],
            ),
        );
    }
}