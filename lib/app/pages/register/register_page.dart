import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/components/control/control_page_component.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/widgets/suports_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:helppyapp/app/controllers/register_controller.dart';

class CadastroPage extends StatefulWidget {
    final String tokenNotification;
    CadastroPage(this.tokenNotification);
    @override
    _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
    RegisterController controllerRegister = RegisterController();
    
    @override
    void initState(){
        super.initState();
        
        autorun((_){
            switch(controllerRegister.statusRegister){
                case 0:
                    showAlertDialog(
                        context,
                        "Insira uma imagem de perfil!",
                        "Por favor, clique no ícone de perfil e insira uma imagem."
                    );
                    break;
                case 1:
                    showAlertDialog(
                        context,
                        "Este email já está em uso!",
                        "Por favor, escolha um outro email, esse já está sendo usado."
                    );
                    break;
                case 2:
                    showAlertDialog(
                        context,
                        "Preencha todos os campos!",
                        "Por favor, verifique se não esqueceu de preencher corretamente todos os campos."
                    );
                    break;
                case 3:
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                            return ControlPage();
                        },
                    ));
                    break;
            }
        });
    }

    Future<void> _choose(RegisterController controller) async {
        controller.file = await ImagePicker.pickImage(source: ImageSource.gallery);
        controller.changeProfileImage(controller.file);
    }

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final controller = Provider.of<MainTabController>(context);
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
                                    await _choose(controllerRegister);
                                },
                                child: Observer(
                                    builder: (_){
                                        return Container(
                                            width: 140,
                                            height: 140,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(140.0),
                                                border: Border.all(
                                                    color: controllerRegister.fileProfileImage == null ? Colors.transparent : COR_AZUL,
                                                    width: controllerRegister.fileProfileImage == null ? 0.0 : 2.0
                                                )
                                            ),
                                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(140.0),
                                                child: controllerRegister.fileProfileImage == null ?
                                                Image.asset(
                                                    "assets/images/user-icon.png",
                                                ) :
                                                Image.file(
                                                    controllerRegister.fileProfileImage,
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
                                            controller: controllerRegister.nomeCadController,
                                            onChanged: controllerRegister.newName,
                                            decoration: InputDecoration(
                                                labelText: "Nome completo",
                                                errorText: controllerRegister.validateFullName(),
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
                                            controller: controllerRegister.emailCadController,
                                            onChanged: controllerRegister.newEmail,
                                            decoration: InputDecoration(
                                                errorText: controllerRegister.validateEmail,
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
                                    controller: controllerRegister.senhaCadController,
                                    onChanged: controllerRegister.newPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "Senha",
                                        errorText: controllerRegister.validatePassword(),
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
                                    controller: controllerRegister.confirmSenhaCadController,
                                    obscureText: true,
                                    onChanged: controllerRegister.newConfirmPassword,
                                    decoration: InputDecoration(
                                        labelText: "Confirme sua senha",
                                        errorText: controllerRegister.validateConfirmPasswod(),
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
                                    controller: controllerRegister.telCadController,
                                    onChanged: controllerRegister.newTelephone,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Telefone",
                                        errorText: controllerRegister.validateTelephone(),
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
                                            controller: controllerRegister.cepCadController,
                                            onChanged: controllerRegister.newCep,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                errorText: controllerRegister.errortextCep.length > 1 ? controllerRegister.errortextCep : null,
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
                                    controller: controllerRegister.endCadController,
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
                                    controller: controllerRegister.numeroCadController,
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
                                    controller: controllerRegister.refCadController,
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
                                                            controllerRegister.typeOne = value;
                                                            controllerRegister.typeTwo = value == true ? false : value;
                                                        });
                                                    },
                                                    value: controllerRegister.typeOne,
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
                                                            controllerRegister.typeTwo = value;
                                                            controllerRegister.typeOne = value == true ? false : value;
                                                        });
                                                    },
                                                    value: controllerRegister.typeTwo,
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
                                        controllerRegister.register(context, controller, widget.tokenNotification);
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
