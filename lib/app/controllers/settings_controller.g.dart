// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsController, Store {
  Computed<dynamic> _$validateEmailComputed;

  @override
  dynamic get validateEmail =>
      (_$validateEmailComputed ??= Computed<dynamic>(() => super.validateEmail))
          .value;

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

  final _$emailAtom = Atom(name: '_SettingsController.email');

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

  final _$cepAtom = Atom(name: '_SettingsController.cep');

  @override
  String get cep {
    _$cepAtom.context.enforceReadPolicy(_$cepAtom);
    _$cepAtom.reportObserved();
    return super.cep;
  }

  @override
  set cep(String value) {
    _$cepAtom.context.conditionallyRunInAction(() {
      super.cep = value;
      _$cepAtom.reportChanged();
    }, _$cepAtom, name: '${_$cepAtom.name}_set');
  }

  final _$errortextCepAtom = Atom(name: '_SettingsController.errortextCep');

  @override
  String get errortextCep {
    _$errortextCepAtom.context.enforceReadPolicy(_$errortextCepAtom);
    _$errortextCepAtom.reportObserved();
    return super.errortextCep;
  }

  @override
  set errortextCep(String value) {
    _$errortextCepAtom.context.conditionallyRunInAction(() {
      super.errortextCep = value;
      _$errortextCepAtom.reportChanged();
    }, _$errortextCepAtom, name: '${_$errortextCepAtom.name}_set');
  }

  final _$updateAsyncAction = AsyncAction('update');

  @override
  Future<void> update() {
    return _$updateAsyncAction.run(() => super.update());
  }

  final _$newCepAsyncAction = AsyncAction('newCep');

  @override
  Future<dynamic> newCep(String value) {
    return _$newCepAsyncAction.run(() => super.newCep(value));
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
  void newEmail(String value) {
    final _$actionInfo = _$_SettingsControllerActionController.startAction();
    try {
      return super.newEmail(value);
    } finally {
      _$_SettingsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'fileProfileImage: ${fileProfileImage.toString()},email: ${email.toString()},cep: ${cep.toString()},errortextCep: ${errortextCep.toString()},validateEmail: ${validateEmail.toString()}';
    return '{$string}';
  }
}
