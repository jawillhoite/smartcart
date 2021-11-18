import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smartcart/src/app.dart';

import 'package:smartcart/src/data/shopping_list.dart';
import 'package:smartcart/src/widgets/item.dart';
import '../data/user.dart' as globals;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();

  // Reference to the real-time datbase
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrent(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            appBar: AppBar(title: const Center(child: Text('Waiting'))),
            );
        }else{
          if (snapshot.hasError){
            return Scaffold(
              appBar: AppBar(title: const Center(child: Text('Choose a current list!')),),
              );
          }else{
            try{
              UserShoppingList myShoppingList=snapshot.data;
              return Scaffold(
                appBar: AppBar(title: Center(child: Text(myShoppingList.name)),),
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
                                    addItemToList(myShoppingList);
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
                        children: List.generate(myShoppingList.listOfItems.length, (index) {
                          return ItemWidget(
                            itemName: myShoppingList.listOfItems[index][0],
                            myList: myShoppingList,
                            function: removeItemFromList,
                            databaseList: 'cartList/' + globals.currUser + '/' + myShoppingList.name + '/listOfItems',
                            selected: myShoppingList.listOfItems[index][1],
                          );
                        }),
                      ),
                    )
                  ]
                )
              );
            } catch (e) {
              return const Text('ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
            }
          }
        }
      }
    );
  }

  Future<UserShoppingList> getCurrent() async {
    DataSnapshot data = await database.child('cartList/' + globals.currUser + '/current').once();
    if (data.value != null) {
      return await readList(data.value);
    } else {
      return UserShoppingList('Pick A Current List', [] ,false, true);
    }
  }

  Future<UserShoppingList> readList(listName) async {
    DataSnapshot test = await (database.child('cartList/' + globals.currUser + '/' + listName).once());
    List itemList = [];
    try {
      itemList = test.value['listOfItems'];
    } catch (e) {
      itemList = [];
    }
    return UserShoppingList(listName, itemList ,test.value['favorite'], test.value['current']);
  }

  void addItemToList(L) async {
    if (nameController.text != '') {
      if (L.listOfItems
          .any((listElement) => listElement == nameController.text)) {
        return;
      } else {
        List added = [];
        L.listOfItems.forEach((element) {
          added.add(element);
        });
        added.add([nameController.text,false]);
        await database.child('cartList/' + globals.currUser + '/' + L.name + '/listOfItems').set(added);
        nameController.text='';
        setState(() {
        });
      }
    }
  }

  void removeItemFromList(L,text) async {
    List removed = [];
    L.listOfItems.forEach((element) {
      if (element != text) {
        removed.add(element);
      }
    });
    await database.child('cartList/' + globals.currUser + '/' + L.name + '/listOfItems').set(removed);
    setState(() {
    });
  }
}
