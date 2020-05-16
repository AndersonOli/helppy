import 'package:flutter/material.dart';
import 'package:helppyapp/includes/general/pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:helppyapp/includes/tabhome/aceitar_pedido.dart';
import 'package:helppyapp/includes/tabhome/tab_request_help.dart';
import 'package:helppyapp/controllers/controllerTab.dart';
import 'welcome.dart';
import 'package:helppyapp/includes/widgets/suports_widgets.dart';

class ControlPage extends StatefulWidget {
    @override
    _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
    String tokenNotification;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    @override
    void initState() {
        super.initState();
        getTokenNotification();

        _firebaseMessaging.configure(
            onMessage: (Map<String, dynamic> message) async {
                print('onMessage: $message');
                this.alertNotification(message["notification"]["title"], message["notification"]["body"]);
            },
            onLaunch: (Map<String, dynamic> message) async {
                print('onMessage: $message');
                this.alertNotification(message["notification"]["title"], message["notification"]["body"]);
            },
            onResume: (Map<String, dynamic> message) async {
                print('onResume: $message');
                this.alertNotification(message["notification"]["title"], message["notification"]["body"]);
            },
        );
    }

    Future<void> getTokenNotification() async {
        tokenNotification = await _firebaseMessaging.getToken();
    }

    Future<void> alertNotification(String title, String message) async {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                        title,
                        style: TextStyle(
                            color: COR_AZUL,
                            fontSize: 18.0
                        ),
                    ),
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                Text(
                                    message,
                                    style: TextStyle(
                                        color: COR_AZUL,
                                        fontSize: 16.0
                                    ),
                                )
                            ],
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
    }

    @override
    Widget build(BuildContext context) {
        final controller = Provider.of<HomeController>(context);
        return FutureBuilder(
            future: controller.getPreferences(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return loadingCenter();
                } else {
                    if(snapshot.data['logged'] != 1){
                        return WelcomeScreen(tokenNotification);
                    } else if(snapshot.data['onRequest'] == 1){
                        return AcceptRequest(snapshot.data['infoRequest']);
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
                            floatingActionButton: snapshot.data['type_acc'] == "0" ? Container(width: 0.0,height: 0.0,) : Padding(
                                padding: EdgeInsets.only(right: 5.0, bottom: 10.0),
                                child: FloatingActionButton(
                                    elevation: 0.0,
                                    child: Icon(Icons.add, color: COR_BRANCO,),
                                    backgroundColor: COR_PRETA,
                                    onPressed: () async {
                                        var result = await Navigator.push(context, MaterialPageRoute(
                                            builder: (context){
                                                return RequestHelp();
                                            },
                                        ));

                                        if(result){
                                            controller.changePage(0);
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