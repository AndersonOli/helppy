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

  final _$emailExistsAtom = Atom(name: '_ControllerForgot.emailExists');

  @override
  bool get emailExists {
    _$emailExistsAtom.context.enforceReadPolicy(_$emailExistsAtom);
    _$emailExistsAtom.reportObserved();
    return super.emailExists;
  }

  @override
  set emailExists(bool value) {
    _$emailExistsAtom.context.conditionallyRunInAction(() {
      super.emailExists = value;
      _$emailExistsAtom.reportChanged();
    }, _$emailExistsAtom, name: '${_$emailExistsAtom.name}_set');
  }

  final _$verifyCodeAtom = Atom(name: '_ControllerForgot.verifyCode');

  @override
  String get verifyCode {
    _$verifyCodeAtom.context.enforceReadPolicy(_$verifyCodeAtom);
    _$verifyCodeAtom.reportObserved();
    return super.verifyCode;
  }

  @override
  set verifyCode(String value) {
    _$verifyCodeAtom.context.conditionallyRunInAction(() {
      super.verifyCode = value;
      _$verifyCodeAtom.reportChanged();
    }, _$verifyCodeAtom, name: '${_$verifyCodeAtom.name}_set');
  }

  final _$isValidCodeAtom = Atom(name: '_ControllerForgot.isValidCode');

  @override
  bool get isValidCode {
    _$isValidCodeAtom.context.enforceReadPolicy(_$isValidCodeAtom);
    _$isValidCodeAtom.reportObserved();
    return super.isValidCode;
  }

  @override
  set isValidCode(bool value) {
    _$isValidCodeAtom.context.conditionallyRunInAction(() {
      super.isValidCode = value;
      _$isValidCodeAtom.reportChanged();
    }, _$isValidCodeAtom, name: '${_$isValidCodeAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_ControllerForgot.password');

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

  final _$confirmPasswordAtom = Atom(name: '_ControllerForgot.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.context.enforceReadPolicy(_$confirmPasswordAtom);
    _$confirmPasswordAtom.reportObserved();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.context.conditionallyRunInAction(() {
      super.confirmPassword = value;
      _$confirmPasswordAtom.reportChanged();
    }, _$confirmPasswordAtom, name: '${_$confirmPasswordAtom.name}_set');
  }

  final _$errorTextAtom = Atom(name: '_ControllerForgot.errorText');

  @override
  String get errorText {
    _$errorTextAtom.context.enforceReadPolicy(_$errorTextAtom);
    _$errorTextAtom.reportObserved();
    return super.errorText;
  }

  @override
  set errorText(String value) {
    _$errorTextAtom.context.conditionallyRunInAction(() {
      super.errorText = value;
      _$errorTextAtom.reportChanged();
    }, _$errorTextAtom, name: '${_$errorTextAtom.name}_set');
  }

  final _$passwordChangedAtom = Atom(name: '_ControllerForgot.passwordChanged');

  @override
  bool get passwordChanged {
    _$passwordChangedAtom.context.enforceReadPolicy(_$passwordChangedAtom);
    _$passwordChangedAtom.reportObserved();
    return super.passwordChanged;
  }

  @override
  set passwordChanged(bool value) {
    _$passwordChangedAtom.context.conditionallyRunInAction(() {
      super.passwordChanged = value;
      _$passwordChangedAtom.reportChanged();
    }, _$passwordChangedAtom, name: '${_$passwordChangedAtom.name}_set');
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
  void setCode(String value) {
    final _$actionInfo = _$_ControllerForgotActionController.startAction();
    try {
      return super.setCode(value);
    } finally {
      _$_ControllerForgotActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_ControllerForgotActionController.startAction();
    try {
      return super.setPassword(value);
    } finally {
      _$_ControllerForgotActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_ControllerForgotActionController.startAction();
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_ControllerForgotActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'email: ${email.toString()},isValidEmail: ${isValidEmail.toString()},onLoading: ${onLoading.toString()},emailExists: ${emailExists.toString()},verifyCode: ${verifyCode.toString()},isValidCode: ${isValidCode.toString()},password: ${password.toString()},confirmPassword: ${confirmPassword.toString()},errorText: ${errorText.toString()},passwordChanged: ${passwordChanged.toString()}';
    return '{$string}';
  }
}
