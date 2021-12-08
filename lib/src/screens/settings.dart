import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Settings')),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: SettingsContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      // ...[
      //   Text(
      //     'Settings',
      //     style: Theme.of(context).textTheme.headline4,
      //   ),
      //   Link(
      //     uri: Uri.parse('/profile'),
      //     builder: (context, followLink) => TextButton(
      //       onPressed: followLink,
      //       child: const Text('View Profile'),
      //     ),
      //   ),
        
      // ].map((w) => Padding(padding: const EdgeInsets.all(8), child: w)),
      Row(
        children: [
          Icon(
            Icons.person,
            color: Colors.green,
          ),
          SizedBox(width: 8,),
          Text(
            "Account",
            style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],          
      ),
      Row(
        children: [
          Link(
          uri: Uri.parse('/profile'),
          builder: (context, followLink) => TextButton(
            onPressed: followLink,
            child: const Text('View Profile'),
          ),
        ),
        ],
      ),
      Divider(height: 15, thickness:  3,),
      Row(
        children: [
          Icon(
            Icons.settings,
            color: Colors.green,
          ),
          SizedBox(width: 8,),
          Text(
            "Settings",
            style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          
        ],        
      ),
      SizedBox(height: 8,),
      Row(children: [Text(
        "This is the Setting",
        style:  TextStyle(fontSize: 12, ),
      ),],),
      Divider(height: 25, thickness:  3,),      
      Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.green, 
          ),
          SizedBox(width: 8,),
          Text(
            "About",
            style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),        
        ],
      ),
      Text(
        "Project of SmartCart is design by Jonathan Ogden, Anthony Sharp, and Jacob Willoite",
        style:  TextStyle(fontSize: 12),
      ),
    ],
  );
}