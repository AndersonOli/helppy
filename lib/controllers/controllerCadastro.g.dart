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

  final _$nameAtom = Atom(name: '_ControllerCadastro.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_ControllerCadastro.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_ControllerCadastro.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$_ControllerCadastroActionController =
      ActionController(name: '_ControllerCadastro');

  @override
  void changeProfileImage(dynamic value) {
    final _$actionInfo = _$_ControllerCadastroActionController.startAction();
    try {
      return super.changeProfileImage(value);
    } finally {
      _$_ControllerCadastroActionController.endAction(_$actionInfo);
    }
  }

  @override
  void newName(String value) {
    final _$actionInfo = _$_ControllerCadastroActionController.startAction();
    try {
      return super.newName(value);
    } finally {
      _$_ControllerCadastroActionController.endAction(_$actionInfo);
    }
  }

  @override
  void newEmail(String value) {
    final _$actionInfo = _$_ControllerCadastroActionController.startAction();
    try {
      return super.newEmail(value);
    } finally {
      _$_ControllerCadastroActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic newPassword(String value) {
    final _$actionInfo = _$_ControllerCadastroActionController.startAction();
    try {
      return super.newPassword(value);
    } finally {
      _$_ControllerCadastroActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'fileProfileImage: ${fileProfileImage.toString()},name: ${name.toString()},email: ${email.toString()},password: ${password.toString()}';
    return '{$string}';
  }
}
