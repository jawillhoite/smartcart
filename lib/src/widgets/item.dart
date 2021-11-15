import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/src/data/list_dao.dart';
import 'package:smartcart/src/data/shopping_list.dart';
import 'package:smartcart/src/app.dart';


class ItemWidget extends StatefulWidget {
  final String itemName;
  final UserShoppingList myList;
  final Function function;

  const ItemWidget({Key? key, required this.itemName,required this.myList, required this.function}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
    heightFactor: 1,
      child: Card(
        child: Column(
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: const Icon(Icons.close, color:Colors.red, size: 10.0),
                  onTap: () {
                    widget.function(widget.myList, widget.itemName);
                  },
                ),
              ],
            ),
            Center (
              child: Text(widget.itemName),
            ),
          ],
        ),
      ),
    );
  }
}