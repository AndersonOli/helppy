// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllerForgot.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerForgot on _ControllerForgot, Store {
  final _$emailAtom = Atom(name: '_ControllerForgot.email');

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

  final _$isValidEmailAtom = Atom(name: '_ControllerForgot.isValidEmail');

  @override
  bool get isValidEmail {
    _$isValidEmailAtom.context.enforceReadPolicy(_$isValidEmailAtom);
    _$isValidEmailAtom.reportObserved();
    return super.isValidEmail;
  }

  @override
  set isValidEmail(bool value) {
    _$isValidEmailAtom.context.conditionallyRunInAction(() {
      super.isValidEmail = value;
      _$isValidEmailAtom.reportChanged();
    }, _$isValidEmailAtom, name: '${_$isValidEmailAtom.name}_set');
  }

  final _$onLoadingAtom = Atom(name: '_ControllerForgot.onLoading');

  @override
  bool get onLoading {
    _$onLoadingAtom.context.enforceReadPolicy(_$onLoadingAtom);
    _$onLoadingAtom.reportObserved();
    return super.onLoading;
  }

  @override
  set onLoading(bool value) {
    _$onLoadingAtom.context.conditionallyRunInAction(() {
      super.onLoading = value;
      _$onLoadingAtom.reportChanged();
    }, _$onLoadingAtom, name: '${_$onLoadingAtom.name}_set');
  }

  final _$_ControllerForgotActionController =
      ActionController(name: '_ControllerForgot');

  @override
  void verifyEmail(String value) {
    final _$actionInfo = _$_ControllerForgotActionController.startAction();
    try {
      return super.verifyEmail(value);
    } finally {
      _$_ControllerForgotActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'email: ${email.toString()},isValidEmail: ${isValidEmail.toString()},onLoading: ${onLoading.toString()}';
    return '{$string}';
  }
}
