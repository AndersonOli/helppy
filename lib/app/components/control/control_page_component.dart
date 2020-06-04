import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/export_pages_component.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/App/Pages/Settings/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:helppyapp/app/pages/requests/accept_request_page.dart';
import 'package:helppyapp/app/pages/requests/request_help_page.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/pages/welcome/welcome_page.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';

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
                showAlertDialog(context, message["notification"]["title"], message["notification"]["body"]);
            },
            onLaunch: (Map<String, dynamic> message) async {
                print('onMessage: $message');
                showAlertDialog(context, message["notification"]["title"], message["notification"]["body"]);
            },
            onResume: (Map<String, dynamic> message) async {
                print('onResume: $message');
                showAlertDialog(context, message["notification"]["title"], message["notification"]["body"]);
            },
        );
    }

    Future<void> getTokenNotification() async {
        tokenNotification = await _firebaseMessaging.getToken();
    }

    @override
    Widget build(BuildContext context) {
        final controller = Provider.of<MainTabController>(context);
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;
        return FutureBuilder(
            future: controller.getPreferences(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                        width: _width,
                        height: _height,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                            width: 200.0,
                        ),
                    );
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
                                    SettingsTab()
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

                                        if(result == true){
                                            controller.changePage(0);
                                        }
                                    },
                                ),
                            ),
                            bottomNavigationBar: Observer(
                                builder: (BuildContext context) {
                                    return BottomNavigationBar(
                                        type: BottomNavigationBarType.fixed,
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
                                            BottomNavigationBarItem(
                                                title: Text("Settings"),
                                                icon: Icon(Icons.settings)
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