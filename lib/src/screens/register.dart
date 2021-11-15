import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class registerScreen extends StatefulWidget {
//  final ValueChanged<Credentials> onregister;

//  const registerScreen({required this.onregister,Key? key,}) : super(key: key);

  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();
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
                        if(_controllerUsername.value.text == '' /*|| _controllerPassword.value.text != Null*/)
                        { 
                          error = 'No user was create';
                          // Credentials(
                          //   _controllerUsername.value.text,
                          //   _controllerPassword.value.text,
                          
                          // );
                        }
                        else if (_controllerPassword.value.text == '')
                        {
                          error = 'No password was create';
                        }
                        else{
                          print('Could not sign in with those credtials');
                          // error = 'Could not sign in with those credtials';
                        }      
                        print(_controllerUsername.value.text);
                        print(_controllerPassword.value.text);

                      },
                      child: const Text('Create Account'),
                    ),
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