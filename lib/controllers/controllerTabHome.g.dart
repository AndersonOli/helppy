// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllerTabHome.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerTabHome on _ControllerTabHome, Store {
  final _$prefsAtom = Atom(name: '_ControllerTabHome.prefs');

  @override
  dynamic get prefs {
    _$prefsAtom.context.enforceReadPolicy(_$prefsAtom);
    _$prefsAtom.reportObserved();
    return super.prefs;
  }

  @override
  set prefs(dynamic value) {
    _$prefsAtom.context.conditionallyRunInAction(() {
      super.prefs = value;
      _$prefsAtom.reportChanged();
    }, _$prefsAtom, name: '${_$prefsAtom.name}_set');
  }

  final _$futureDataAtom = Atom(name: '_ControllerTabHome.futureData');

  @override
  Future<dynamic> get futureData {
    _$futureDataAtom.context.enforceReadPolicy(_$futureDataAtom);
    _$futureDataAtom.reportObserved();
    return super.futureData;
  }

  @override
  set futureData(Future<dynamic> value) {
    _$futureDataAtom.context.conditionallyRunInAction(() {
      super.futureData = value;
      _$futureDataAtom.reportChanged();
    }, _$futureDataAtom, name: '${_$futureDataAtom.name}_set');
  }

  final _$setPreferencesAsyncAction = AsyncAction('setPreferences');

  @override
  Future<void> setPreferences() {
    return _$setPreferencesAsyncAction.run(() => super.setPreferences());
  }

  final _$_ControllerTabHomeActionController =
      ActionController(name: '_ControllerTabHome');

  @override
  dynamic getResult() {
    final _$actionInfo = _$_ControllerTabHomeActionController.startAction();
    try {
      return super.getResult();
    } finally {
      _$_ControllerTabHomeActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'prefs: ${prefs.toString()},futureData: ${futureData.toString()}';
    return '{$string}';
  }
}
