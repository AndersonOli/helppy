// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tab_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainTabController on _MainTabController, Store {
  final _$selectedIndexAtom = Atom(name: '_MainTabController.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.context.enforceReadPolicy(_$selectedIndexAtom);
    _$selectedIndexAtom.reportObserved();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.context.conditionallyRunInAction(() {
      super.selectedIndex = value;
      _$selectedIndexAtom.reportChanged();
    }, _$selectedIndexAtom, name: '${_$selectedIndexAtom.name}_set');
  }

  final _$prefsAtom = Atom(name: '_MainTabController.prefs');

  @override
  SharedPreferences get prefs {
    _$prefsAtom.context.enforceReadPolicy(_$prefsAtom);
    _$prefsAtom.reportObserved();
    return super.prefs;
  }

  @override
  set prefs(SharedPreferences value) {
    _$prefsAtom.context.conditionallyRunInAction(() {
      super.prefs = value;
      _$prefsAtom.reportChanged();
    }, _$prefsAtom, name: '${_$prefsAtom.name}_set');
  }

  final _$getPreferencesAsyncAction = AsyncAction('getPreferences');

  @override
  Future<dynamic> getPreferences() {
    return _$getPreferencesAsyncAction.run(() => super.getPreferences());
  }

  final _$_MainTabControllerActionController =
      ActionController(name: '_MainTabController');

  @override
  void changePage(int index) {
    final _$actionInfo = _$_MainTabControllerActionController.startAction();
    try {
      return super.changePage(index);
    } finally {
      _$_MainTabControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'selectedIndex: ${selectedIndex.toString()},prefs: ${prefs.toString()}';
    return '{$string}';
  }
}
