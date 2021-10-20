import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/data/list_dao.dart';
import 'package:smartcart/data/shopping_list.dart';
import 'package:smartcart/src/app.dart';

class ListsScreen extends StatefulWidget {
  ListsScreen({Key? key}) : super(key: key);

  final listDao = ListDao();

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
    );
  }

  void _saveShoppingList() {
    final testShoppingList =
        UserShoppingList('testList', ['item1', 'item2'], false, true);
    widget.listDao.saveShoppingList(testShoppingList);
  }

  // get the text in the TextField and start the Second Screen
  void _sendDataToSecondScreen(
      BuildContext context, UserShoppingList listToSend) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            shoppingList: listToSend,
          ),
        ));
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

  @override
  Widget build(BuildContext context) {
    final UserShoppingList shoppinglist = widget.shoppingList;
    return Scaffold(
        appBar: AppBar(title: Text(shoppinglist.name)),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item Name',
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Add Item'),
            onPressed: () {
              addItemToList();
            },
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: shoppinglist.listOfItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child:
                          Center(child: Text(shoppinglist.listOfItems[index])),
                    );
                  }))
        ]));
  }

  void addItemToList() {
    //dont add if empty string or already in list
    if (nameController.text != '') {
      if (widget.shoppingList.listOfItems
          .any((listElement) => listElement.contains(nameController.text))) {
        return;
      } else {
        setState(() {
          widget.shoppingList.listOfItems.add(nameController.text);
        });
        //TODO: Save new item to database
      }
    }
  }
}
