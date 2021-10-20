import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smartcart/data/list_dao.dart';
import 'package:smartcart/data/shopping_list.dart';

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
              // _saveShoppingList(); //This throws error
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
}

// class ListsContent extends StatelessWidget {
//   ListsContent({
//     Key? key,
//   }) : super(key: key);

//   final listDao = ListDao();

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 3,
//       childAspectRatio: .75,
//       crossAxisSpacing: 7,
//       mainAxisSpacing: 7,
//       padding: const EdgeInsets.all(15),
//       children: List.generate(10, (index) {
//         return Card(
//           child: InkWell(
//             child: Center(child: Text("List $index")),
//             onTap: () {
//               print("TAPPY TAP ON #$index");
//               _saveShoppingList();
//             },
//           ),
//         );
//       }),
//     );
//   }

//   void _saveShoppingList() {
//     final testShoppingList =
//         UserShoppingList('testList', ['item1', 'item2'], false, true);
//     print('2nd');
//     listDao.saveShoppingList(testShoppingList);
//     // widget.listDao.saveShoppingList(testShoppingList);
//     print('saved');
//   }
// }
