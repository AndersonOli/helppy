import 'package:flutter/material.dart';
import 'package:helppyapp/includes/aceitar_pedido.dart';
import 'package:helppyapp/includes/tab_request_help.dart';
import 'package:helppyapp/pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome.dart';

class ControlPage extends StatefulWidget {
    bool wasLogged;
    ControlPage(this.wasLogged);
    @override
    _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
    int currentTab = 0;
    int isLogged;
    String typeAcc;
    int onRequest;
    String infoRequest;
    var prefs;

    List<Widget> tabs = [
        HomeTab(),
        NewsTab(),
        HelpTab(),
    ];

    changeTab(int index){
        setState(() {
            currentTab = index;
        });
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
        return FutureBuilder(
            future: setValue(),
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
                                strokeWidth: 5.0,
                            ),
                        );
                    case ConnectionState.done:
                        if(snapshot.data[1] != 1){
                            return WelcomeScreen();
                        } else if(snapshot.data[2] == 1){
                            return AcceptRequest(infoRequest);
                        } else {
                            return Scaffold(
                                body: Stack(
                                    children: <Widget>[
                                        tabs[currentTab],
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: _buildBottomAppBar,
                                        ),
                                    ],
                                ),
                                floatingActionButton: snapshot.data[0] == "0" ? Container(width: 0.0,height: 0.0,) : Padding(
                                    padding: EdgeInsets.only(right: 5.0, bottom: 65.0),
                                    child: FloatingActionButton(
                                        child: Icon(Icons.add, color: COR_BRANCO,),
                                        backgroundColor: COR_PRETA,
                                        onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                    return RequestHelp();
                                                },
                                            ));
                                        },
                                    ),
                                ),
                            );
                        }
                        break;
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    break;
                }
            },
        );
    }

    Widget get _buildBottomAppBar {
        return ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
//                backgroundColor: COR_STROKE,
                onTap: changeTab,
                currentIndex: currentTab,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                    BottomNavigationBarItem(
                        title: Text("Início"),
                        icon: Icon(HellpyIcons.help, color: currentTab == 0 ? COR_AZUL : COR_CINZA)
                    ),
                    BottomNavigationBarItem(
                        title: Text("Notícias"),
                        icon: Icon(HellpyIcons.newspaper, color: currentTab == 1 ? COR_AZUL : COR_CINZA)
                    ),
                    BottomNavigationBarItem(
                        title: Text("Dicas"),
                        icon: Icon(HellpyIcons.soap, color: currentTab == 2 ? COR_AZUL : COR_CINZA)
                    ),
                ]
            ),
        );
    }
}
