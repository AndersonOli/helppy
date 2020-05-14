import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/controllers/controllerTabHome.dart';
import 'package:helppyapp/includes/widgets/card_idoso.dart';
import 'package:helppyapp/includes/widgets/card_voluntario.dart';
import 'package:helppyapp/includes/general/globals.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
    @override
    _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {


    @override
    Widget build(BuildContext context) {
        final controllerHome = Provider.of<ControllerTabHome>(context);
        controllerHome.getResult();
        return Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Column(
                children: <Widget>[
                    Expanded(
                        child: Observer(
                            builder: (_){
                                return FutureBuilder(
                                    future: controllerHome.futureData,
                                    builder: (context, snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                            return loadingCenter();
                                        } else {
                                            final _width = MediaQuery.of(context).size.width;
                                            final _height = MediaQuery.of(context).size.height;
                                            print(snapshot.data);

                                            if(snapshot.data == null || snapshot.data.length <= 0){
                                                return RefreshIndicator(
                                                    onRefresh: () async {
                                                        controllerHome.getResult();
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                            controllerHome.prefs.getString("type_acc") == "0" ? "Não há pedidos para ajudar no momento." : "Você ainda não fez nenhum pedido. Se precisa de ajuda, clique no botão com o + abaixo..",
                                                            style: TextStyle(
                                                                color: COR_AZUL,
                                                                fontSize: 18.0,
                                                            ),
                                                        ),
                                                    ),
                                                );
                                            } else {
                                                return SingleChildScrollView(
                                                    child: Container(
                                                        width: _width,
                                                        height: _height,
                                                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                                        child: RefreshIndicator(
                                                            onRefresh: () async {
                                                                controllerHome.getResult();
                                                            },
                                                            child: ListView.builder(
                                                                itemCount: snapshot.data.length,
                                                                shrinkWrap: true,
                                                                itemBuilder: (context, index){
                                                                    return controllerHome.prefs.getString("type_acc") == "0" ? CardVoluntario(index: index, snapshot: snapshot, responseDistance: controllerHome.responseDistance,) : CardIdoso(snapshot: snapshot, controllerHome: controllerHome, index: index,);
                                                                },
                                                            ),
                                                        ),
                                                    ),
                                                );
                                            }
                                        }
                                    }
                                );
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}



