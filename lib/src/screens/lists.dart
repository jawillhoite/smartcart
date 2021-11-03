import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/src/data/list_dao.dart';
import 'package:smartcart/src/data/shopping_list.dart';
import 'package:smartcart/src/app.dart';

import '../screens/item_list.dart';

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

  final myLists = [];

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
        children: List.generate(myLists.length, (index) {
          return FractionallySizedBox(
            heightFactor: 1,
            child: Card(
              child: InkWell(
                onTap: () {
                  print("TAPPY TAP ON #$index");
                  // _saveShoppingList(); // a test, This throws error

                  //TODO: get data from database instead of using testlist
                  // Send shopping list from here to display on next page
                  readList(myLists[index]).then((myList) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemsScreen(
                          shoppingList: myList,
                        ),
                      ));
                  });
                },
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
                            removeList(myLists[index]);
                          },
                        ),
                      ],
                    ),
                    Center (
                      child: Text(myLists[index]),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void addList() async {
    if (listNameController.text != '') {
      if (myLists
          .any((listElement) => listElement.contains(listNameController.text))) {
        return;
      } else {
        UserShoppingList newList = UserShoppingList(listNameController.text, [], false, false);
        setState(() {
          myLists.add(listNameController.text);
          listNameController.text='';
        });
        await database.child('cartList/Username/' + newList.name).set(newList.toJson());
      }
    }
  }

  void removeList(text) async {
    setState(() {
      myLists.remove(text);
    });
    await database.child('cartList/Username/' + text).remove();
  }

  Future<UserShoppingList> readList(listName) async {
    DataSnapshot test = await (database.child('cartList/Username/' + listName).once());
    List itemList = [];
    try {
      itemList = test.value['listOfItems'];
    } catch (e) {
      itemList = [];
    }
    return UserShoppingList(listName, itemList ,test.value['favorite'], test.value['current']);
  }

}