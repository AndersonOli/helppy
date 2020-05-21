import 'package:mobx/mobx.dart';
part 'controllerCadastro.g.dart';

class ControllerCadastro = _ControllerCadastro with _$ControllerCadastro;

abstract class _ControllerCadastro with Store {
    @observable
    var fileProfileImage;

    @action
    void changeProfileImage(dynamic value) => fileProfileImage = value;

    @observable
    String name = "";

    @action
    void changeName(String value) => name = value;

    @observable
    String email = "";

    @action
    void changeEmail(String value) => email = value;

    @observable
    String password = "";

    @action
    changePassword(String value) => password = value;

    String validateName() {
        if (name == null || name.isEmpty) {
            return "Este campo é obrigatório";
        }
        return null;
    }
}