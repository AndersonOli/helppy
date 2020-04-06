import 'package:flutter/material.dart';

class NewsTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    Divider(),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                    )
                ],
            ),
        );
    }
}
