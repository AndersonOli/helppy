import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'controllerTab.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
    final PageController pageController = PageController();

    void setPreferences(String preference, dynamic value) {
        switch(value.runtimeType){
            case String:
                prefs.setString(preference, value);
                break;
            case int:
                prefs.setInt(preference, value);
                break;
        }
    }

    @observable
    int selectedIndex = 0;

    @action
    void changePage(int index) {
        pageController.jumpToPage(index);
        selectedIndex = index;
    }

    @observable
    SharedPreferences prefs;

    @action
    Future getPreferences() async {
        prefs = await SharedPreferences.getInstance();
        return {
            'type_acc': prefs.getString('type_acc'),
            'logged': prefs.getInt('logged'),
            'onRequest': prefs.getInt('onRequest'),
            'infoRequest': prefs.getString('infoRequest'),
            'token': prefs.getString('token'),
            'user_id': prefs.getInt('user_id'),
            'name': prefs.getString('')
        };
    }
}