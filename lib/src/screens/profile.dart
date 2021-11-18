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
      appBar: AppBar(title: const Center(child: Text('My Profile')),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: ProfileContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ...[
            CircleAvatar(
              backgroundColor: Colors.green,
              child: const Text('SC'),
              radius: 50,
            ),
            Text(
              globals.currUser,
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                ShoppingListAuthScope.of(context).signOut();
              },
              child: const Text('Sign out'),
            ),
            
            Text(
              'This is the profile',
              style: const TextStyle(fontSize: 20)
            ),
          ].map((w) => Padding(padding: const EdgeInsets.all(8), child: w)),
        ],
      );
}