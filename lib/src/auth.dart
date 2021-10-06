import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// A mock authentication service
class ShoppingListAuth extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is ShoppingListAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;
}

class ShoppingListAuthScope extends InheritedNotifier<ShoppingListAuth> {
  const ShoppingListAuthScope({
    required ShoppingListAuth notifier,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: notifier, child: child);

  static ShoppingListAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<ShoppingListAuthScope>()!
      .notifier!;
}