import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';
import 'package:helppyapp/ui/control_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CadastroPage extends StatefulWidget {
    @override
    _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
    bool typeOne = false;
    bool typeTwo = false;
    int typeAcc;
    var prefs;
    String latitude, longitude;

    @override
    void initState() {
        super.initState();
        setValue();
    }

    void setValue() async {
        prefs = await SharedPreferences.getInstance();
    }

    final TextEditingController _nomeCadController = TextEditingController();
    final TextEditingController _emailCadController = TextEditingController();
    final TextEditingController _senhaCadController = TextEditingController();
    final TextEditingController _telCadController = TextEditingController();
    final TextEditingController _cepCadController = TextEditingController();
    final TextEditingController _endCadController = TextEditingController();
    final TextEditingController _numeroCadController = TextEditingController();
    final TextEditingController _refCadController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
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
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: _nomeCadController,
                                    decoration: InputDecoration(
                                        labelText: "Nome completo",
                                        hintText: "Insira seu nome completo",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: _emailCadController,
                                    decoration: InputDecoration(
                                        labelText: "Email",
                                        hintText: "Insira seu email",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: _senhaCadController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "Senha",
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
                                    controller: _telCadController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Telefone",
                                        hintText: "Insira o número do seu telefone",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: _cepCadController,
                                    onChanged: (value){
                                        if(value.length == 8){
                                            _completeCEP();
                                        }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "CEP",
                                        hintText: "Insira seu CEP",
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: TextField(
                                    controller: _endCadController,
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
                                    controller: _numeroCadController,
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
                                child: TextField(
                                    controller: _refCadController,
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
                                                            typeOne = value;
                                                            typeTwo = value == true ? false : value;
                                                        });
                                                    },
                                                    value: typeOne,
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
                                                            typeTwo = value;
                                                            typeOne = value == true ? false : value;
                                                        });
                                                    },
                                                    value: typeTwo,
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
                                child: RaisedButton(
                                    onPressed: (){
                                        doCadastro();
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

    doCadastro() async {
        typeAcc = typeOne == true ? 1 : 0;

        http.Response data = await http.post(
            'https://helppy-19.herokuapp.com/register',
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
                "full_name": _nomeCadController.text,
                "email": _emailCadController.text.toLowerCase().trim(),
                "password": _senhaCadController.text,
                "telephone": _telCadController.text.trim(),
                "cep": _cepCadController.text.trim(),
                "address": _endCadController.text,
                "house_number": _numeroCadController.text.trim(),
                "reference": _refCadController.text,
                "type_account": typeAcc.toString(),
                "latitude": latitude,
                "longitude": longitude
            }),
        );

        if(data.body.contains('duplicate key value violates unique constraint')){
            showAlertDialog(
                context,
                "Este email já está em uso!",
                "Por favor, escolha um outro email, esse já está sendo usado."
            );
        } else if(data.body.contains('null value in column')){
            showAlertDialog(
                context,
                "Preencha todos os campos!",
                "Por favor, preencha todos os campos, verifique se você não esqueceu de algum."
            );
        } else if(data.body.contains(_emailCadController.text.toLowerCase().trim())){
            http.Response data = await http.post(
                'https://helppy-19.herokuapp.com/authenticate',
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                    "email": _emailCadController.text.toLowerCase().trim(),
                    "password": _senhaCadController.text
                }),
            );
            var dados = json.decode(data.body);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                    prefs.setInt('logged', 1);
                    prefs.setString('token', dados["token"]);
                    prefs.setInt('user_id', dados["user_id"]);
                    prefs.setString('type_acc', dados["type_account"]);
                    return ControlPage(true);
                },
            ));
        }
    }

    _completeCEP() async {
        if(_cepCadController.text != null){
            var endereco = await http.get(
                "http://www.cepaberto.com/api/v3/cep?cep=" + _cepCadController.text.trim(),
                headers: {'Authorization': 'Token token=471dec71c96f8dbc684056839dc3411b'}
            );
            var data = jsonDecode(endereco.body);

            latitude = data["latitude"];
            longitude = data["longitude"];

            setState(() {
                _endCadController.text = data["logradouro"] + " - " + data["bairro"] + " - " + data["cidade"]["nome"] + "-" + data["estado"]["sigla"];
                _refCadController.text = data["complemento"];
            });
        }
    }
}
