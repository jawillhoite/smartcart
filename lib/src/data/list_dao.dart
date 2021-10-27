import 'package:firebase_database/firebase_database.dart';
import 'shopping_list.dart';

//Shopping List data access object
class ListDao {
  final DatabaseReference _listsRef =
      FirebaseDatabase.instance.reference().child('lists');

  void saveShoppingList(UserShoppingList shoppingList) async {
    _listsRef.push().set(shoppingList
        .toJson()); //throws error bc it cant find plugin function set(), idk why its dumb
  }

  Query getShoppingListQuery() {
    return _listsRef;
  }
}
