import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/src/data/list_dao.dart';
import 'package:smartcart/src/data/shopping_list.dart';
import 'package:smartcart/src/app.dart';

class ItemsScreen extends StatefulWidget {
  final UserShoppingList shoppingList;

  // TextEditingController nameController = TextEditingController();

  // receive data from the FirstScreen as a parameter
  ItemsScreen({Key? key, required this.shoppingList}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  TextEditingController nameController = TextEditingController();

  // Reference to the real-time datbase
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    UserShoppingList shoppinglist = widget.shoppingList;


    return Scaffold(
        appBar: AppBar(title: Text(shoppinglist.name)),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.orange,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: Colors.white60,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Item Name',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Add Item'),
                          onPressed: () {
                            addItemToList();
                          },
                        ),
                      ],
                    ) 
                  )
                );
              },
            );
          },
        ),
        body: Column(
          children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: .75,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              padding: const EdgeInsets.all(15),
              children: List.generate(shoppinglist.listOfItems.length, (index) {
                return FractionallySizedBox(
                  heightFactor: 1,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              MaterialButton(
                                height: 0.1,
                                minWidth: 0.1,
                                child: const Icon(Icons.close, color:Colors.red, size: 10.0),
                                onPressed: () {
                                  removeItemFromList(shoppinglist.listOfItems[index]);
                                },
                              ),
                            ],
                          ),
                          Center (
                            child: Text(shoppinglist.listOfItems[index]),
                          ),
                        ],
                      ),
                    ),
                );
              }),
            ),
          )
        ]
      )
    );
  }

  void addItemToList() async {
    if (nameController.text != '') {
      if (widget.shoppingList.listOfItems
          .any((listElement) => listElement == nameController.text)) {
        return;
      } else {
        List added = [];
        widget.shoppingList.listOfItems.forEach((element) {
          added.add(element);
        });
        added.add(nameController.text);
        widget.shoppingList.listOfItems = added;
        await database.child('cartList/Username/' + widget.shoppingList.name + '/listOfItems').set(added);
        nameController.text='';
        setState(() {
        });
      }
    }
  }

  void removeItemFromList(text) async {
    List removed = [];
    widget.shoppingList.listOfItems.forEach((element) {
      if (element != text) {
        removed.add(element);
      }
    });
    widget.shoppingList.listOfItems = removed;
    await database.child('cartList/Username/' + widget.shoppingList.name + '/listOfItems').set(removed);
    setState(() {
    });
  }
}