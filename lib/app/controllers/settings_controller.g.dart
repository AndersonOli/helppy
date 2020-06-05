// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsController, Store {
  final _$fileProfileImageAtom =
      Atom(name: '_SettingsController.fileProfileImage');

  @override
  dynamic get fileProfileImage {
    _$fileProfileImageAtom.context.enforceReadPolicy(_$fileProfileImageAtom);
    _$fileProfileImageAtom.reportObserved();
    return super.fileProfileImage;
  }

  @override
  set fileProfileImage(dynamic value) {
    _$fileProfileImageAtom.context.conditionallyRunInAction(() {
      super.fileProfileImage = value;
      _$fileProfileImageAtom.reportChanged();
    }, _$fileProfileImageAtom, name: '${_$fileProfileImageAtom.name}_set');
  }

  final _$_SettingsControllerActionController =
      ActionController(name: '_SettingsController');

  @override
  void changeProfileImage(dynamic value) {
    final _$actionInfo = _$_SettingsControllerActionController.startAction();
    try {
      return super.changeProfileImage(value);
    } finally {
      _$_SettingsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'fileProfileImage: ${fileProfileImage.toString()}';
    return '{$string}';
  }
}
