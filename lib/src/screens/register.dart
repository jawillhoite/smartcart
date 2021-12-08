import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

class RegCredentials {
  final String username;
  final String password;

  RegCredentials(this.username, this.password);
}

class registerScreen extends StatefulWidget {

  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();
  final database = FirebaseDatabase.instance.reference();

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [           
          Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create Account', style: Theme.of(context).textTheme.headline4),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: _controllerUsername,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _controllerPassword,
                  ),                  
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () async {
                        var snapShot_UserData = await database.child('cartList').once();
                        var userList = [];
                        try{
                        Map <dynamic,dynamic> usernames = snapShot_UserData.value;
                        usernames.forEach((key, value) {
                          userList.add(key);
                        });
                        } catch (e) {
                           setState(() => error = 'no users');
                        }
                        if(_controllerUsername.value.text == '')
                        { 
                          setState(() => error = 'No user was create');
                        }
                        else if (_controllerPassword.value.text == '')
                        {
                          setState(() => error = 'No password was create');
                        }
                        else if (_controllerUsername.value.text == '' || _controllerPassword.value.text =='')
                        {
                          setState(() => error = 'Could not sign in with those credtials');
                        }
                        else if(userList.contains(_controllerUsername.value.text)) 
                        {
                          setState(() => error = 'User already exist');
                        } 
                        else
                        {
                          print(_controllerUsername.value.text);
                          print(_controllerPassword.value.text);
                          print('Success');
                          database.child('cartList/'+_controllerUsername.value.text+'/password').set(_controllerPassword.value.text);
                          _controllerUsername.text = '';
                          _controllerPassword.text = '';
                        }
                      },
                      child: const Text('Create Account'),
                    ),
                  ),
                  Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}