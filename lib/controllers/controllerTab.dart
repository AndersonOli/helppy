import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'controllerTab.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
    var pageController = PageController();
    var pageControllerHome = PageController();

    @observable
    bool didUpdate = false;

    @observable
    int selectedIndex = 0;

    @observable
    bool wasPop = false;

    @action
    void wasPoped(){
        wasPop = true;
    }

    @action
    void changePage(int index) {
        pageController.jumpToPage(index);
        selectedIndex = index;
    }

    @action
    void updatePage(bool update) {
        pageControllerHome.jumpToPage(0);
        this.changePage(0);
    }
}