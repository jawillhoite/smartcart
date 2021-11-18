import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/src/data/list_dao.dart';
import 'package:smartcart/src/data/shopping_list.dart';

import '../screens/item_list.dart';
import '../data/user.dart' as globals;

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

  List myLists = [];
  List myFavoriteLists = [];
  List allLists = [];
  var currentList = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateLists(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            appBar: AppBar(title: const Center(child: Text('My Lists'))),
            );
        }else{
          if (snapshot.hasError){
            return const Text("ERROR");
          }else{
            try{
              Map<dynamic, dynamic> lists=snapshot.data.value;
              lists.forEach((k,v) {
                if (k != 'current' && k != 'password'){
                  if (v['favorite'] && !myFavoriteLists.contains(k)) {
                    myFavoriteLists.add(k.toString());
                  } else if (!v['favorite'] && !myLists.contains(k)) {
                    myLists.add(k.toString());
                  }
                } else {
                  if (k == 'current'){
                  currentList = v;}
                }
              });
              myFavoriteLists.sort();
              myLists.sort();
              allLists = myFavoriteLists + myLists;
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
                                      //print(myLists);
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
                  children: List.generate(allLists.length, (index) {
                    return FractionallySizedBox(
                      heightFactor: 1,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            readList(allLists[index]).then((allList) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsScreen(
                                    shoppingList: allList,
                                  ),
                                ));
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: const Icon(Icons.close, color:Colors.red, size: 10),
                                    onTap: () {
                                      removeList(allLists[index]);
                                    },
                                  ),
                                  InkWell(
                                    child: 
                                    (allLists[index] != currentList) ?
                                    const Icon(Icons.home_outlined, color:Colors.black, size: 15):
                                    const Icon(Icons.home, color:Colors.blue, size: 15),
                                    onTap: () {
                                      setCurrentList(allLists[index]);
                                    },
                                  ),
                                  InkWell(
                                    child:
                                      (myLists.any((listElement) => listElement == allLists[index])) ?
                                      const Icon(Icons.star_border_outlined, color:Colors.black, size: 15):
                                      const Icon(Icons.stars, color:Colors.amber, size: 15),
                                    onTap: () {
                                      favoriteList(allLists[index]);
                                      if (myLists.any((listElement) => listElement == allLists[index])) {
                                        myFavoriteLists.add(allLists[index]);
                                        myLists.remove((allLists[index]));
                                      } else {
                                        myLists.add((allLists[index]));
                                        myFavoriteLists.remove(allLists[index]);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Center (
                                child: Text(allLists[index]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            } catch (e) {
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
                                    //print(myLists);
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
              );
            }
          }
        }
      }
    );
  }

  Future<DataSnapshot> updateLists() async {
    return await database.child('cartList/' + globals.currUser).once();
  }

  void addList() async {
    if (listNameController.text != '') {
      if (myLists.any((listElement) => listElement ==listNameController.text) || 
          myFavoriteLists.any((listElement) => listElement == listNameController.text)) {
        return;
      } else {
        UserShoppingList newList = UserShoppingList(listNameController.text, [], false, false);
        setState(() {
          myLists.add(listNameController.text);
          listNameController.text='';
        });
        await database.child('cartList/' + globals.currUser + '/' + newList.name).set(newList.toJson());
      }
    }
  }

  void removeList(text) async {
    if (myFavoriteLists
          .any((listElement) => listElement == text)) {
    setState(() {
      myFavoriteLists.remove(text);
    });
    } else {
      setState(() {
      myLists.remove(text);
    });
    }
    await database.child('cartList/' + globals.currUser + '/' + text).remove();
  }

  void favoriteList(listName) async {
    UserShoppingList theList = await readList(listName);
    await database.child('cartList/' + globals.currUser + '/' + listName + '/favorite').set(!theList.favorite);
    setState(() {
    });
  }

  void setCurrentList(current) async {
    DataSnapshot lists = await (database.child('cartList/' + globals.currUser + '/').once());
    lists.value.forEach((k,v) {
      if (k != 'password'){
      database.child('cartList/' + globals.currUser + '/' + k.toString() + '/current').set(false);}
    });
    await database.child('cartList/' + globals.currUser + '/' + current + '/current').set(true);
    await database.child('cartList/' + globals.currUser + '/current').set(current);
    currentList = current;
    setState(() {
    });
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

}