import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';

class NewsTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[
                    LimitedBox(
                        maxHeight: 270,
                        child: Card(
                            margin: EdgeInsets.only(top: 20.0),
                            color: azulStd,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                    Divider(),
                                    Text("Dados do coronavírus",
                                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                                        textAlign: TextAlign.center,
                                    ),
                                    Divider(),
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(textosNoticia, style: TextStyle(color: brancoStd, fontSize: 18.0),),
                                    )
                                ],
                            ),
                        ),
                    )
                ],
            ),
        );
    }

    var textosNoticia =
        'Última atualização: 30/30/3030 às 30:30\n\n' +
        'Teresina - Piauí\n' +
        '\t\t\t\tCasos confirmados: 100\n' +
        'Brazil\n' +
        '\t\t\t\tCasos confirmados: 1032';
}
