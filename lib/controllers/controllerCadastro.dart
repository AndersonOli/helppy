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
    void newName(String value) => name = value;

    String validateFullName() {
        String pattern = r'^[a-z A-Z,.\-]+$';
        RegExp regExp = new RegExp(pattern);
        if (name.length == 0) {
            return 'Por Favor digite seu nome completo.';
        } else if (!regExp.hasMatch(name)) {
            return 'Por favor digite um nome completo válido.';
        }
        return null;
    }
// copiar do que o Anderson já fez
    @observable
    String email = "";

    @action
    void newEmail(String value) => email = value;

    @observable
    String password = "";

    @action
    void newPassword(String value) => password = value;

    String validatePassword() {
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])$';
        RegExp regExp = new RegExp(pattern);
        if (regExp.hasMatch(password) == false) {
            return 'A senha precisa conter pelo menos um carácter maiúsculo, minúsculo e numeral.';
        }
        return null;
    }

    @observable
    String telephone = "";

    @action
    void newTelephone (String value) => telephone = value;

    String validateTelephone (){
        String pattern = r'^([1-9]{2}) (?:[2-8]|9[1-9])[0-9]{3}[0-9]{4}$';
        RegExp regExp = new RegExp(pattern);
        if (regExp.hasMatch(telephone) == false) {
            return 'O seu telefone deve está nesse parâmetro ddd xxxxxxxxx, o ddd sem o 0 a esquerda';
        }
        return null;
    }

    @computed
    bool get isValid {
        return validateFullName() == null && validateTelephone() == null && validatePassword() == null;
    }

}