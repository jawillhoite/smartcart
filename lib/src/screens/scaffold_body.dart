import 'package:flutter/material.dart';

import '../routing.dart';
import '../screens/home.dart';
import '../screens/lists.dart';
import '../screens/scan.dart';
import '../screens/profile.dart';
import '../screens/settings.dart';
import '../widgets/fade_transition_page.dart';
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

    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        if (currentRoute.pathTemplate.startsWith('/home'))
          const FadeTransitionPage<void>(
            key: ValueKey('home'),
            child: HomeScreen(),
          )
        else if (currentRoute.pathTemplate.startsWith('/lists'))
          FadeTransitionPage<void>(
            key: ValueKey('lists'),
            child: ListsScreen(),
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
        else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}
