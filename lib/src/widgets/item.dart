import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/src/data/shopping_list.dart';


class ItemWidget extends StatefulWidget {
  final String itemName;
  final UserShoppingList myList;
  final Function function;
  final String databaseList;
  bool selected;

  ItemWidget({Key? key, required this.itemName,required this.myList, required this.function, required this.databaseList, required this.selected}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {

    // Reference to the real-time datbase
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
    heightFactor: 1,
      child: Card(
        shape: widget.selected
          ? RoundedRectangleBorder(
            side: const BorderSide(color: Colors.blue, width: 4.0),
            borderRadius: BorderRadius.circular(4.0))
          : RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 4.0),
            borderRadius: BorderRadius.circular(4.0)),
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
            Expanded(
              child: Align (
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: widget.selected
                  ? const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Icon(Icons.check_circle, color: Colors.blue, size: 20.0))
                  : const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(Icons.check_circle_outline, size: 15.0)),
                  onTap: () {
                    setState(() {
                      widget.selected = !widget.selected;
                    });
                    database.child(widget.databaseList + '/0/1').set(widget.selected);
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}