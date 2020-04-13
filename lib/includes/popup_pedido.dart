import 'package:flutter/material.dart';


class PopUpPedidos extends StatelessWidget {
    bool _screen;
    PopUpPedidos(this._screen);
    @override
    Widget build(BuildContext context) {
        if(_screen){
            return Text("Pedido confirmado");
        }
        return Text("Ocorreu um erro :(");
    }
}
