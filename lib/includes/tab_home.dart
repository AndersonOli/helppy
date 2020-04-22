import 'package:flutter/material.dart';
import 'package:helppyapp/globals.dart';

class HomeTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;
        return SingleChildScrollView(
            child: Container(
                width: _width,
                height: _height,
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                        return _cardPedido(context);
                    },
                ),
            ),
        );
    }

    Widget _cardPedido(context){
        final _width = MediaQuery.of(context).size.width;
        return Container(
            width: _width,
            height: 200.0,
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: COR_AZUL,
                borderRadius: BorderRadius.circular(10.0)
            ),
        );
    }
}
