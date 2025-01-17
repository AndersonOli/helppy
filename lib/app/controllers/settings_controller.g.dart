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

  final _$linkImgAtom = Atom(name: '_SettingsController.linkImg');

  @override
  dynamic get linkImg {
    _$linkImgAtom.context.enforceReadPolicy(_$linkImgAtom);
    _$linkImgAtom.reportObserved();
    return super.linkImg;
  }

  @override
  set linkImg(dynamic value) {
    _$linkImgAtom.context.conditionallyRunInAction(() {
      super.linkImg = value;
      _$linkImgAtom.reportChanged();
    }, _$linkImgAtom, name: '${_$linkImgAtom.name}_set');
  }

  final _$fileAtom = Atom(name: '_SettingsController.file');

  @override
  File get file {
    _$fileAtom.context.enforceReadPolicy(_$fileAtom);
    _$fileAtom.reportObserved();
    return super.file;
  }

  @override
  set file(File value) {
    _$fileAtom.context.conditionallyRunInAction(() {
      super.file = value;
      _$fileAtom.reportChanged();
    }, _$fileAtom, name: '${_$fileAtom.name}_set');
  }

  final _$dataAtom = Atom(name: '_SettingsController.data');

  @override
  dynamic get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(dynamic value) {
    _$dataAtom.context.conditionallyRunInAction(() {
      super.data = value;
      _$dataAtom.reportChanged();
    }, _$dataAtom, name: '${_$dataAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_SettingsController.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
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

  final _$statusUpdateAtom = Atom(name: '_SettingsController.statusUpdate');

  @override
  int get statusUpdate {
    _$statusUpdateAtom.context.enforceReadPolicy(_$statusUpdateAtom);
    _$statusUpdateAtom.reportObserved();
    return super.statusUpdate;
  }

  @override
  set statusUpdate(int value) {
    _$statusUpdateAtom.context.conditionallyRunInAction(() {
      super.statusUpdate = value;
      _$statusUpdateAtom.reportChanged();
    }, _$statusUpdateAtom, name: '${_$statusUpdateAtom.name}_set');
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
  Future<void> update(SharedPreferences prefs, BuildContext context) {
    return _$updateAsyncAction.run(() => super.update(prefs, context));
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
        'fileProfileImage: ${fileProfileImage.toString()},linkImg: ${linkImg.toString()},file: ${file.toString()},data: ${data.toString()},loading: ${loading.toString()},email: ${email.toString()},statusUpdate: ${statusUpdate.toString()},cep: ${cep.toString()},errortextCep: ${errortextCep.toString()},validateEmail: ${validateEmail.toString()}';
    return '{$string}';
  }
}
