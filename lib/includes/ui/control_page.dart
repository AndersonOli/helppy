import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/includes/tabhome/aceitar_pedido.dart';
import 'package:helppyapp/includes/tabhome/tab_request_help.dart';
import 'package:helppyapp/includes/general/pages.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helppyapp/controllers/controllerTab.dart';
import 'welcome.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';

class ControlPage extends StatefulWidget {
    final bool wasLogged;
    ControlPage(this.wasLogged);
    @override
    _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
    var prefs;
    Future _value;
    int isLogged, onRequest;
    String typeAcc, infoRequest;

    @override
    void initState() {
        super.initState();
        _value = setValue();
    }

    Future<dynamic> setValue() async {
        prefs = await SharedPreferences.getInstance();
        typeAcc = prefs.getString('type_acc');
        isLogged = prefs.getInt('logged');
        onRequest = prefs.getInt('onRequest');
        infoRequest = prefs.getString('infoRequest');
        return [typeAcc, isLogged, onRequest];
    }

    @override
    Widget build(BuildContext context) {
        final controller = Provider.of<HomeController>(context);
        return FutureBuilder(
            future: _value,
            builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return loadingCenter();
                } else {
                    if(snapshot.data[1] != 1){
                        return WelcomeScreen();
                    } else if(snapshot.data[2] == 1){
                        return AcceptRequest(infoRequest);
                    } else {
                        return Scaffold(
                            body: PageView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: controller.pageController,
                                children: [
                                    HomeTab(),
                                    NewsTab(),
                                    HelpTab(),
                                ],
                            ),
                            floatingActionButton: snapshot.data[0] == "0" ? Container(width: 0.0,height: 0.0,) : Padding(
                                padding: EdgeInsets.only(right: 5.0, bottom: 10.0),
                                child: FloatingActionButton(
                                    elevation: 0.0,
                                    child: Icon(Icons.add, color: COR_BRANCO,),
                                    backgroundColor: COR_PRETA,
                                    onPressed: () async {
                                        final result = await Navigator.push(context, MaterialPageRoute(
                                            builder: (context){
                                                return RequestHelp();
                                            },
                                        ));

                                        if(result == true){
                                            controller.wasPoped();
                                        }
                                    },
                                ),
                            ),
                            bottomNavigationBar: Observer(
                                builder: (BuildContext context) {
                                    return BottomNavigationBar(
                                        onTap: (index) => controller.changePage(index),
                                        currentIndex: controller.selectedIndex,
                                        showSelectedLabels: false,
                                        showUnselectedLabels: false,
                                        selectedItemColor: COR_AZUL,
                                        unselectedItemColor: COR_CINZA,
                                        items: [
                                            BottomNavigationBarItem(
                                                title: Text("Início"),
                                                icon: Icon(HellpyIcons.help)
                                            ),
                                            BottomNavigationBarItem(
                                                title: Text("Notícias"),
                                                icon: Icon(HellpyIcons.newspaper)
                                            ),
                                            BottomNavigationBarItem(
                                                title: Text("Dicas"),
                                                icon: Icon(HellpyIcons.soap)
                                            ),
                                        ]
                              );
                                },
                            )
                        );
                    }
                }
            },
        );
    }
}