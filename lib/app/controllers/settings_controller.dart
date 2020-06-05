import 'package:mobx/mobx.dart';
part 'settings_controller.g.dart';

class SettingsController = _SettingsController with _$SettingsController;

abstract class _SettingsController with Store {
  @observable
  var fileProfileImage;

  @action
  void changeProfileImage(dynamic value) => fileProfileImage = value;


}