import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:provider/provider.dart';
import 'package:helppyapp/app/controllers/register_controller.dart';

class CadastroPage extends StatefulWidget {
    final String tokenNotification;
    CadastroPage(this.tokenNotification);
    @override
    _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

    Future<void> _choose(RegisterController controller) async {
        controller.file = await ImagePicker.pickImage(source: ImageSource.camera);
        controller.changeProfileImage(controller.file);
    }

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final controller = Provider.of<MainTabController>(context);
        final controllerCadastro = Provider.of<RegisterController>(context);
        return Scaffold(
            appBar: AppBar(
                backgroundColor: COR_AZUL,
                title: Text("Informe os dados para se cadastrar"),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        children: <Widget>[
                            GestureDetector(
                                onTap: () async {
                                    await _choose(controllerCadastro);
                                },
                                child: Observer(
                                    builder: (_){
                                        return Container(
                                            width: 140,
                                            height: 140,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(140.0),
                                                border: Border.all(
                                                    color: controllerCadastro.fileProfileImage == null ? Colors.transparent : COR_AZUL,
                                                    width: controllerCadastro.fileProfileImage == null ? 0.0 : 2.0
                                                )
                                            ),
                                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(140.0),
                                                child: controllerCadastro.fileProfileImage == null ?
                                                Image.asset(
                                                    "assets/images/user-icon.png",
                                                ) :
                                                Image.file(
                                                    controllerCadastro.fileProfileImage,
                                                    fit: BoxFit.cover,
                                                    width: 140,
                                                    height: 140,
                                                ),
                                            ),
                                        );
                                    },
                                ),
                            ),
                            Observer(
                                builder: (_){
                                    return Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: TextField(
                                            controller: controllerCadastro.nomeCadController,
                                            onChanged: controllerCadastro.newName,
                                            decoration: InputDecoration(
                                                labelText: "Nome completo",
                                                errorText: controllerCadastro.validateFullName(),
                                                hintText: "Insira seu nome completo",
                                                border: OutlineInputBorder(),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                            ),
                                        ),
                                    );
                                }
                            ),
                            Observer(
                                builder: (context) {
                                    return Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: TextField(
                                            controller: controllerCadastro.emailCadController,
                                            onChanged: controllerCadastro.newEmail,
                                            decoration: InputDecoration(
                                                errorText: controllerCadastro.validateEmail,
                                                labelText: "Email",
                                                hintText: "Insira seu email",
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                const EdgeInsets.symmetric(horizontal: 10),
                                            ),
                                        ),
                                    );
                                }
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: controllerCadastro.senhaCadController,
                                    onChanged: controllerCadastro.newPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "Senha",
                                        errorText: controllerCadastro.validatePassword(),
                                        hintText: "Insira uma senha",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: controllerCadastro.confirmSenhaCadController,
                                    obscureText: true,
                                    onChanged: controllerCadastro.newConfirmPassword,
                                    decoration: InputDecoration(
                                        labelText: "Confirme sua senha",
                                        errorText: controllerCadastro.validateConfirmPasswod(),
                                        hintText: "Insira a mesma senha digitada anteriormente",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextFormField(
                                    maxLength: 11,
                                    controller: controllerCadastro.telCadController,
                                    onChanged: controllerCadastro.newTelephone,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Telefone",
                                        errorText: controllerCadastro.validateTelephone(),
                                        hintText: "Insira o número do seu telefone",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Observer(
                                builder: (context){
                                    return Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                            maxLength: 8,
                                            controller: controllerCadastro.cepCadController,
                                            onChanged: controllerCadastro.newCep,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                errorText: controllerCadastro.errortextCep.length > 1 ? controllerCadastro.errortextCep : null,
                                                labelText: "CEP",
                                                hintText: "Insira seu CEP",
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                const EdgeInsets.symmetric(horizontal: 10),
                                            ),
                                        ),
                                    );
                                },
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: controllerCadastro.endCadController,
                                    decoration: InputDecoration(
                                        labelText: "Endereço",
                                        hintText: "Insira seu endereço",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: controllerCadastro.numeroCadController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Número da casa",
                                        hintText: "Insira o número da sua casa",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextFormField(
                                    controller: controllerCadastro.refCadController,
                                    decoration: InputDecoration(
                                        labelText: "Ponto de referência",
                                        hintText: "Insira um ponto de referência",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                                child: Text(
                                    "Qual o seu propósito com o Helpy?",
                                    style: TextStyle(
                                        color: COR_AZUL,
                                        fontSize: 18.0,
                                    ),
                                ),
                            ),
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: Row(
                                            children: <Widget>[
                                                Checkbox(
                                                    onChanged: (bool value){
                                                        setState(() {
                                                            controllerCadastro.typeOne = value;
                                                            controllerCadastro.typeTwo = value == true ? false : value;
                                                        });
                                                    },
                                                    value: controllerCadastro.typeOne,
                                                ),
                                                Text(
                                                    "Pedir ajuda",
                                                    style: TextStyle(
                                                        color: COR_AZUL,
                                                        fontSize: 18.0,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Row(
                                            children: <Widget>[
                                                Checkbox(
                                                    onChanged: (bool value){
                                                        setState(() {
                                                            controllerCadastro.typeTwo = value;
                                                            controllerCadastro.typeOne = value == true ? false : value;
                                                        });
                                                    },
                                                    value: controllerCadastro.typeTwo,
                                                ),
                                                Text(
                                                    "Ajudar",
                                                    style: TextStyle(
                                                        color: COR_AZUL,
                                                        fontSize: 18.0,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    )
                                ],
                            ),
                            Container(
                                width: _width,
                                margin: EdgeInsets.only(top: 20.0),
                                child: FlatButton(
                                    onPressed: (){
                                        controllerCadastro.doCadastro(context, controller, widget.tokenNotification);
                                    },
                                    color: COR_AZUL,
                                    child: Text(
                                        "Cadastrar",
                                        style: TextStyle(
                                            color: COR_BRANCO,
                                            fontSize: 18.0,
                                        ),
                                    ),
                                ),
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}
