import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';
import '../data/user.dart' as globals;


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Profile')),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.all(30),            
              child: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                globals.currUser[0].toUpperCase(),
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
              radius: 50,
            ),            
          ),            
          Text(
            'This is ' + globals.currUser + ' profile',
            style: const TextStyle(fontSize: 20),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     Alignment.bottomCenter;
          //     ShoppingListAuthScope.of(context).signOut();
          //   },
          //   child: const Text('Sign out'),
          // ),
          OutlinedButton(
            onPressed: (){ShoppingListAuthScope.of(context).signOut();}, 
            child: Text('SIGN OUT',
            style: TextStyle(fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
          ),
            
          ],
        ),
      ),
    );
  }
}
