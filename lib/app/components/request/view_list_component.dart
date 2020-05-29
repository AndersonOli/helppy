import 'package:flutter/material.dart';
import 'package:helppyapp/app/components/general/globals_component.dart';

class ViewList extends StatefulWidget {
    final List list;
    ViewList(this.list);
    @override
    _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: COR_AZUL,
            ),
            body: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index){
                    return Container(
                        height: 45.0,
                        margin: index == 0 ? EdgeInsets.only(top: 10.0) : EdgeInsets.only(top: 5.0),
                        decoration: BoxDecoration(
                            color: COR_AZUL,
                            border: Border.all(
                                color: COR_STROKE,
                                width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            widget.list[index],
                            style: TextStyle(fontSize: 20, color: COR_BRANCO),
                        ),
                    );
                }
            ),
        );
    }
}
