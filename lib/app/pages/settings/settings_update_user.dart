import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/controllers/register_controller.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUser extends StatelessWidget {
  //TODO: controller update to user
//  RegisterController controllerRegister = RegisterController();
  Future<void> _choose(RegisterController controller) async {
//    controller.file = await ImagePicker.pickImage(source: ImageSource.camera);
//    controller.changeProfileImage(controller.file);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
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
                //TODO: controller update to user
//                await _choose(controllerRegister);
              },
              child: Observer(
                builder: (_){
                  return Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(140.0),
                        border: Border.all(
                          //TODO: controller update to user
//                            color: controllerRegister.fileProfileImage == null ? Colors.transparent : COR_AZUL,
//                            width: controllerRegister.fileProfileImage == null ? 0.0 : 2.0
                        )
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(140.0),
                      //TODO: controller update to user
                      child: controllerRegister.fileProfileImage == null ?
                      Image.asset(
                        "assets/images/user-icon.png",
                      ) :
                      Image.file(
                        //TODO: controller update to user
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
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "CEP",
                  hintText: "Insira seu CEP",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
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
                onPressed: (){},
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
