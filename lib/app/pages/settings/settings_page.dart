import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';

class SettingsTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return Scaffold(
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                margin: EdgeInsets.only(top: 10.0),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(right: 20.0),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100.0),
                                                child: Image.network(
                                                    "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                                                    width: 100.0,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                ),
                                            ),
                                        ),
                                        Expanded(
                                            child: Column(
                                                children: <Widget>[
                                                    Container(
                                                        child: Text(
                                                            "Anderson Oliveira",
                                                            style: TextStyle(
                                                                color: COR_AZUL,
                                                                fontSize: 18.0
                                                            ),
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                                                        child: Divider(),
                                                    ),
                                                    SizedBox(
                                                        width: double.infinity,
                                                        child: FlatButton(
                                                            color: COR_PRETA,
                                                            onPressed: (){},
                                                            child: Text(
                                                                "Editar minhas informações",
                                                                style: TextStyle(
                                                                    color: COR_BRANCO,
                                                                    fontSize: 16.0
                                                                ),
                                                            ),
                                                        ),
                                                    )
                                                ],
                                            ),
                                        )
                                    ],
                                ),
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}
