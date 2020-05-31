// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInController, Store {
  Computed<dynamic> _$validateEmailComputed;

  @override
  dynamic get validateEmail =>
      (_$validateEmailComputed ??= Computed<dynamic>(() => super.validateEmail))
          .value;

  final _$emailAtom = Atom(name: '_SignInController.email');

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

  final _$passwordAtom = Atom(name: '_SignInController.password');

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

  final _$statusSignInAtom = Atom(name: '_SignInController.statusSignIn');

  @override
  bool get statusSignIn {
    _$statusSignInAtom.context.enforceReadPolicy(_$statusSignInAtom);
    _$statusSignInAtom.reportObserved();
    return super.statusSignIn;
  }

  @override
  set statusSignIn(bool value) {
    _$statusSignInAtom.context.conditionallyRunInAction(() {
      super.statusSignIn = value;
      _$statusSignInAtom.reportChanged();
    }, _$statusSignInAtom, name: '${_$statusSignInAtom.name}_set');
  }

  final _$_SignInControllerActionController =
      ActionController(name: '_SignInController');

  @override
  void newEmail(String value) {
    final _$actionInfo = _$_SignInControllerActionController.startAction();
    try {
      return super.newEmail(value);
    } finally {
      _$_SignInControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void newPassword(String value) {
    final _$actionInfo = _$_SignInControllerActionController.startAction();
    try {
      return super.newPassword(value);
    } finally {
      _$_SignInControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'email: ${email.toString()},password: ${password.toString()},statusSignIn: ${statusSignIn.toString()},validateEmail: ${validateEmail.toString()}';
    return '{$string}';
  }
}
