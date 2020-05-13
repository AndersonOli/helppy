// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllerCadastro.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerCadastro on _ControllerCadastro, Store {
  final _$fileProfileImageAtom =
      Atom(name: '_ControllerCadastro.fileProfileImage');

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

  final _$_ControllerCadastroActionController =
      ActionController(name: '_ControllerCadastro');

  @override
  dynamic changeProfileImage(dynamic value) {
    final _$actionInfo = _$_ControllerCadastroActionController.startAction();
    try {
      return super.changeProfileImage(value);
    } finally {
      _$_ControllerCadastroActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'fileProfileImage: ${fileProfileImage.toString()}';
    return '{$string}';
  }
}
