// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllerTab.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$didUpdateAtom = Atom(name: '_HomeBase.didUpdate');

  @override
  bool get didUpdate {
    _$didUpdateAtom.context.enforceReadPolicy(_$didUpdateAtom);
    _$didUpdateAtom.reportObserved();
    return super.didUpdate;
  }

  @override
  set didUpdate(bool value) {
    _$didUpdateAtom.context.conditionallyRunInAction(() {
      super.didUpdate = value;
      _$didUpdateAtom.reportChanged();
    }, _$didUpdateAtom, name: '${_$didUpdateAtom.name}_set');
  }

  final _$selectedIndexAtom = Atom(name: '_HomeBase.selectedIndex');

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

  final _$_HomeBaseActionController = ActionController(name: '_HomeBase');

  @override
  void changePage(int index) {
    final _$actionInfo = _$_HomeBaseActionController.startAction();
    try {
      return super.changePage(index);
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePage(bool update) {
    final _$actionInfo = _$_HomeBaseActionController.startAction();
    try {
      return super.updatePage(update);
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'didUpdate: ${didUpdate.toString()},selectedIndex: ${selectedIndex.toString()}';
    return '{$string}';
  }
}