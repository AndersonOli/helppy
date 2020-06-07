import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/controllers/settings_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  Future<void> _choose(SettingsController controller) async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    controller.changeProfileImage(file);
  }

  @override
  Widget build(BuildContext context) {
    final MainTabController controllerMain = Provider.of<MainTabController>(context);
    final SettingsController controllerSettings = Provider.of<SettingsController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COR_AZUL,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await _choose(controllerSettings);
              },
              child: Observer(
                builder: (_){
                  return Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(140.0),
                        border: Border.all(
                            color: controllerSettings.fileProfileImage == null ? Colors.transparent : COR_AZUL,
                            width: controllerSettings.fileProfileImage == null ? 0.0 : 2.0
                        )
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(140.0),
                      child: controllerSettings.fileProfileImage == null ?
                      Image.asset(
                        "assets/images/user-icon.png",
                      ) :
                      controllerSettings.fileProfileImage.toString().contains("http") ?
                      Image.network(
                        controllerSettings.fileProfileImage,
                        fit: BoxFit.cover,
                        width: 140,
                        height: 140,
                      ) : Image.file(
                        controllerSettings.fileProfileImage,
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
                    onChanged: controllerSettings.newEmail,
                    controller: controllerSettings.emailUpdateController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Insira seu email",
                      errorText: controllerSettings.validateEmail,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                maxLength: 11,
                controller: controllerSettings.telUpdateController,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  hintText: "Insira seu telefone",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            Observer(
              builder: (_){
                return Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    maxLength: 8,
                    controller: controllerSettings.cepUpdateController,
                    onChanged: controllerSettings.newCep,
                    decoration: InputDecoration(
                      labelText: "CEP",
                      hintText: "Insira seu CEP",
                      errorText: controllerSettings.errortextCep == "" ? null : controllerSettings.errortextCep,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: controllerSettings.endUpdateController,
                decoration: InputDecoration(
                  labelText: "Endereço",
                  hintText: "Insira seu endereço",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: controllerSettings.numeroUpdateController,
                decoration: InputDecoration(
                  labelText: "Número da casa",
                  hintText: "Insira o número da sua casa",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: controllerSettings.refUpdateController,
                decoration: InputDecoration(
                  labelText: "Ponto de referência",
                  hintText: "Insira um ponto de referência",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                onPressed: (){
                  controllerSettings.update(controllerMain.prefs, context);
                },
                color: COR_PRETA,
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                      color: COR_BRANCO
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}