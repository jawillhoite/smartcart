import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/src/data/list_dao.dart';
import 'package:smartcart/src/data/shopping_list.dart';
import 'package:smartcart/src/app.dart';

class ListsScreen extends StatefulWidget {
  ListsScreen({Key? key}) : super(key: key);

  final listDao = ListDao();

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  TextEditingController listNameController = TextEditingController();

  // Reference to the real-time datbase
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('My Lists'))),
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
                            controller: listNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'List Name',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Add List'),
                          onPressed: () {
                            addList();
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
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: .75,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        padding: const EdgeInsets.all(15),
        children: List.generate(10, (index) {
          return Card(
            child: InkWell(
              child: Center(child: Text("List $index")),
              onTap: () {
                print("TAPPY TAP ON #$index");
                // _saveShoppingList(); // a test, This throws error

                //TODO: get data from database instead of using testlist
                // Send shopping list from here to display on next page
                UserShoppingList testlist = UserShoppingList("List $index",
                    ['item1', "item2", '3', '4', '5'], true, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        shoppingList: testlist,
                      ),
                    ));
              },
            ),
          );
        }),
      ),
    );
  }

  void addList() async {
    if (listNameController.text != '') {
      if (widget.shoppingList.listOfItems
          .any((listElement) => listElement.contains(nameController.text))) {
        return;
      } else {
        setState(() {
          widget.shoppingList.listOfItems.add(nameController.text);
          nameController.text='';
        });
        await database.child('cartList/October/Username/' + '1').set(widget.shoppingList.toJson());
      }
    }
  }
}

class SecondScreen extends StatefulWidget {
  final UserShoppingList shoppingList;

  // TextEditingController nameController = TextEditingController();

  // receive data from the FirstScreen as a parameter
  SecondScreen({Key? key, required this.shoppingList}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController nameController = TextEditingController();

  // Reference to the real-time datbase
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final UserShoppingList shoppinglist = widget.shoppingList;


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

    // writing to the child of the tree of the database
    //final cartList = database.child(); 
    
    //dont add if empty string or already in list
    if (nameController.text != '') {
      if (widget.shoppingList.listOfItems
          .any((listElement) => listElement.contains(nameController.text))) {
        return;
      } else {
        setState(() {
          widget.shoppingList.listOfItems.add(nameController.text);
          nameController.text='';
        });
        await database.child('cartList/October/Username/' + '1').set(widget.shoppingList.toJson());
      }
    }
  }

  void removeItemFromList(text) {
    setState(() {
      widget.shoppingList.listOfItems.remove(text);
    });
  }
}