import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class createAccountScreen extends StatefulWidget {
 // final ValueChanged<Credentials> onCreateAccount;

 // const createAccountScreen({required this.onCreateAccount,Key? key,}) : super(key: key);

  @override
  _createAccountScreenState createState() => _createAccountScreenState();
}

class _createAccountScreenState extends State<createAccountScreen> {
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerEmail = TextEditingController();
 

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
                  // TextField(
                  //   decoration: const InputDecoration(labelText: 'Email'),
                  //   obscureText: true,
                  //   controller: _controllerEmail,
                  // ),
                  
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () async {
                        
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