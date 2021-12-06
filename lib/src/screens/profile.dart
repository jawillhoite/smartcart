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
              globals.currUser,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('This is the profile', style: const TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                alignment: Alignment.bottomCenter;
                ShoppingListAuthScope.of(context).signOut();
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.edit),
      //   backgroundColor: Colors.orange,
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return Container(
      //           height: 200,
      //           color: Colors.white60,
      //           child: Center(
      //             child: Column(
      //               children: <Widget>[
      //                 Padding(
      //                   padding: const EdgeInsets.all(20),
      //                   child: TextField(
      //                     decoration: const InputDecoration(
      //                       border: OutlineInputBorder(),
      //                       labelText: 'Edit Profile',
      //                     ),
      //                   ),
      //                 ),                      
      //               ],
      //             ) 
      //           )
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
