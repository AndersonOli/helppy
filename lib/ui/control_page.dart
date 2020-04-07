import 'package:flutter/material.dart';
import 'package:helppyapp/pages.dart';

class ControlPage extends StatefulWidget {
    @override
    _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
    int currentTab = 0;
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
    Widget build(BuildContext context) {
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
            floatingActionButton: Padding(
                padding: EdgeInsets.only(right: 5.0, bottom: 65.0),
                child: FloatingActionButton(
                    child: Icon(Icons.add, color: brancoStd,),
                    backgroundColor: azulStd,
                    onPressed: (){
                        requestHelp();
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
                        icon: Icon(HellpyIcons.help, color: currentTab == 0 ? azulStd : cinzaStd)
                    ),
                    BottomNavigationBarItem(
                        title: Text("Notícias"),
                        icon: Icon(HellpyIcons.newspaper, color: currentTab == 1 ? azulStd : cinzaStd)
                    ),
                    BottomNavigationBarItem(
                        title: Text("Dicas"),
                        icon: Icon(HellpyIcons.soap, color: currentTab == 2 ? azulStd : cinzaStd)
                    ),
                ]
            ),
        );
    }
}
