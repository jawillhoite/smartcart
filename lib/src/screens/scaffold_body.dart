import 'package:flutter/material.dart';

import '../routing.dart';
import '../screens/home.dart';
import '../screens/scan.dart';
import '../screens/profile.dart';
import '../screens/settings.dart';
import '../widgets/fade_transition_page.dart';
//import 'authors.dart';
//import 'books.dart';
import 'scaffold.dart';

/// Displays the contents of the body of [ShoppingListScaffold]
class ShoppingListScaffoldBody extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const ShoppingListScaffoldBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentRoute = RouteStateScope.of(context).route;

    // A nested Router isn't necessary because the back button behavior doesn't
    // need to be customized.
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        if (currentRoute.pathTemplate.startsWith('/home'))
          const FadeTransitionPage<void>(
            key: ValueKey('home'),
            child: HomeScreen(),
          )
        else if (currentRoute.pathTemplate.startsWith('/scan'))
          const FadeTransitionPage<void>(
            key: ValueKey('scan'),
            child: ScanScreen(),
          )
        else if (currentRoute.pathTemplate.startsWith('/profile'))
          const FadeTransitionPage<void>(
            key: ValueKey('profile'),
            child: ProfileScreen(),
          )
        else if (currentRoute.pathTemplate.startsWith('/settings'))
          const FadeTransitionPage<void>(
            key: ValueKey('settings'),
            child: SettingsScreen(),
          )
        // Avoid building a Navigator with an empty `pages` list when the
        // RouteState is set to an unexpected path, such as /signin.
        //
        // Since RouteStateScope is an InheritedNotifier, any change to the
        // route will result in a call to this build method, even though this
        // widget isn't built when those routes are active.
        else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}