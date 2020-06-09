import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/controllers/main_tab_controller.dart';
import 'package:helppyapp/app/controllers/settings_controller.dart';
import 'package:helppyapp/app/pages/settings/settings_update_user.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final MainTabController controllerMain =
        Provider.of<MainTabController>(context);
    final SettingsController controllerSettings =
        Provider.of<SettingsController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Stack(
                              children: <Widget>[
                                FutureBuilder(
                                  future: controllerSettings
                                      .recoveryValues(controllerMain.prefs),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: 100.0,
                                        height: 100.0,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  COR_AZUL),
                                        ),
                                      );
                                    } else {
                                      return FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        width: 100.0,
                                        height: 100.0,
                                        image:
                                            controllerSettings.fileProfileImage,
                                      );
                                    }
                                  },
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                controllerMain.prefs.getString("name"),
                                style:
                                    TextStyle(color: COR_AZUL, fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40.0, right: 40.0),
                              child: Divider(),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Observer(
                                builder: (_) {
                                  return FlatButton(
                                    color: COR_PRETA,
                                    disabledColor: COR_CINZA,
                                    onPressed: controllerSettings.loading == true ? null : () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return UpdateUser();
                                      }));
                                    },
                                    child: Text(
                                      "Editar minhas informações",
                                      style: TextStyle(
                                          color: COR_BRANCO, fontSize: 16.0),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Este projeto receberá atualizações futuras e novas funcionalidades serão implementadas.",
                    style: TextStyle(color: COR_PRETA, fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Sobre",
                    style: TextStyle(
                        color: COR_PRETA,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "O Helppy19 é um projeto/ideia criada a partir de um gatilho imposto pelo iCev, "
                    "onde a equipe do Helppy cursa Engenharia de Software e fora proposto um desafio de"
                    "30 dias para criar uma solução que ajudasse diante da pandemia.",
                    style: TextStyle(color: COR_PRETA, fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Contato / Suporte",
                    style: TextStyle(
                        color: COR_PRETA,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "A equipe do Helppy-19 ficaria muito feliz em receber sua opinião sobre o projeto, e caso algum problema ocorreu entre em contato e trabalharemos para resolver. Se aconteceu alguma coisa com o seu pedido nos contate e iremos solucionar.",
                    style: TextStyle(color: COR_PRETA, fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      await launch(
                          "mailto:helppy19@hotmail.com?subject=SUPORTE HELPPY-19");
                    },
                    child: Text(
                      "helppy19@hotmail.com",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: COR_AZUL,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      await launch(
                          "https://api.whatsapp.com/send?phone=5586999580740&text=Ol%C3%A1%2C%20poderia%20me%20ajudar%3F%20%C3%89%20sobre%20o%20Helppy");
                    },
                    child: Text(
                      "(86) 9958-0740",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: COR_AZUL,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _width,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Helppy - versão 1.7",
                    style: TextStyle(color: COR_PRETA, fontSize: 12.0),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
