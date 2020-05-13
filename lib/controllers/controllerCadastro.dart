import 'package:mobx/mobx.dart';
part 'controllerCadastro.g.dart';

class ControllerCadastro = _ControllerCadastro with _$ControllerCadastro;

abstract class _ControllerCadastro with Store {
    @observable
    var fileProfileImage;

    @action
    changeProfileImage(dynamic value) {
        fileProfileImage = value;
    }
}