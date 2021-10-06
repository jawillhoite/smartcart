//import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
//import 'package:smartcart/src/screens/navigator.dart';

import '../routing.dart';
import 'scaffold_body.dart';

class ShoppingListScaffold extends StatelessWidget {
  const ShoppingListScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartCart'),
      ),

      body: const ShoppingListScaffoldBody(),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_outlined),
            label: 'Scan',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: (index){
          switch (index) {
            case 0:
              routeState.go('/home');
              break;
            case 1:
              routeState.go('/scan');
              break;
            case 2:
              routeState.go('/profile');
              break;
            case 3:
              routeState.go('/settings');
              break;  
          }
        }
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/home')) return 0;
    if (pathTemplate == '/scan') return 1;
    if (pathTemplate == '/profile') return 2;
    if (pathTemplate == '/settings') return 3;
    return 0;
  }
}