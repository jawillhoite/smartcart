class UserShoppingList {
  String name;
  List listOfItems;
  bool favorite;
  bool current;

  UserShoppingList(this.name, this.listOfItems, this.favorite, this.current);

  UserShoppingList.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        listOfItems = json['listOfItems'] as List,
        favorite = json['favorite'] as bool,
        current = json['current'] as bool;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'listOfItems': listOfItems,
        'favorite': favorite,
        'current': current,
      };
}
