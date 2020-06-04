import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';
import 'package:helppyapp/app/pages/settings/settings_update_user.dart';
import 'package:transparent_image/transparent_image.dart';

class SettingsTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
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
                                                            Container(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                alignment: Alignment.center,
                                                                child: CircularProgressIndicator(
                                                                    valueColor: AlwaysStoppedAnimation<Color>(COR_AZUL),
                                                                ),
                                                            ),
                                                            FadeInImage.memoryNetwork(
                                                                placeholder: kTransparentImage,
                                                                width: 100.0,
                                                                height: 100.0,
                                                                image: 'https://picsum.photos/250?image=9',
                                                            )
                                                        ],
                                                    )
                                                ),
                                            ),
                                            Expanded(
                                                child: Column(
                                                    children: <Widget>[
                                                        Container(
                                                            child: Text(
                                                                "Anderson Oliveira",
                                                                style: TextStyle(
                                                                    color: COR_AZUL,
                                                                    fontSize: 18.0
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                                                            child: Divider(),
                                                        ),
                                                        SizedBox(
                                                            width: double.infinity,
                                                            child: FlatButton(
                                                                color: COR_PRETA,
                                                                onPressed: (){
                                                                    Navigator.of(context).push(MaterialPageRoute(
                                                                        builder: (context){
                                                                            return UpdateUser();
                                                                        }
                                                                    ));
                                                                },
                                                                child: Text(
                                                                    "Editar minhas informações",
                                                                    style: TextStyle(
                                                                        color: COR_BRANCO,
                                                                        fontSize: 16.0
                                                                    ),
                                                                ),
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
                                        style: TextStyle(
                                            color: COR_PRETA,
                                            fontSize: 16.0
                                        ),
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
                                            fontWeight: FontWeight.w600
                                        ),
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
                                        style: TextStyle(
                                            color: COR_PRETA,
                                            fontSize: 16.0
                                        ),
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
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.left,
                                    ),
                                ),
                                Container(
                                    width: _width,
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                        "A equipe do Helppy-19 ficaria muito feliz em receber sua opinião sobre o projeto, e caso algum problema ocorreu entre em contato e trabalharemos para resolver. Se aconteceu alguma coisa com o seu pedido nos contate e iremos solucionar.\n\nEmail: helpy19@hotmail.com\nWhatsApp: (86) 9958-0740",
                                        style: TextStyle(
                                            color: COR_PRETA,
                                            fontSize: 16.0
                                        ),
                                        textAlign: TextAlign.left,
                                    ),
                                ),
                                Container(
                                    width: _width,
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                        "Helppy - versão 1.7",
                                        style: TextStyle(
                                            color: COR_PRETA,
                                            fontSize: 12.0
                                        ),
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
