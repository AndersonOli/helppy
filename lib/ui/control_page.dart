import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helppyapp/includes/tab_request_help.dart';
import 'package:helppyapp/pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome.dart';

class ControlPage extends StatefulWidget {
    @override
    _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
    int currentTab = 0;
    int launchCount;
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

    @override
    void initState() {
        super.initState();
        setValue();
    }

    void setValue() async {
        final prefs = await SharedPreferences.getInstance();
        int launchCount = prefs.getInt('counter') ?? 0;
        prefs.setInt('counter', launchCount + 1);
//        launchCount=0;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: launchCount == 0 ? WelcomeScreen() : Stack(
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
            floatingActionButton: launchCount == 0 ? Container(width: 0.0,height: 0.0,) : Padding(
                padding: EdgeInsets.only(right: 5.0, bottom: 65.0),
                child: FloatingActionButton(
                    child: Icon(Icons.add, color: COR_BRANCO,),
                    backgroundColor: COR_AZUL,
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

    Widget get _buildBottomAppBar {
        return ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
//                backgroundColor: strokeStd,
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
