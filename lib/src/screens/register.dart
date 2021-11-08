import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

// class Credentials {
//   final String username;
//   final String password;

//   Credentials(this.username, this.password);
// }

class RegisterScreen extends StatefulWidget {
  // final ValueChanged<Credentials> onRegister;
  final Function toggleView;
  RegisterScreen({this.toggleView});

  // const RegisterScreen({
  //   required this.onRegister,
  //   Key? key,
  // }) : super(key: key);
  // const RegisterScreen({required this.onRegister,Key? key,}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerEmail = TextEditingController();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Card(
          child: Container(
            constraints: BoxConstraints.loose(const Size(600, 600)),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Create Account',
                    style: Theme.of(context).textTheme.headline4),
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
                      print(email);
                      print(password);
                      // widget.onRegister(Credentials(
                      //     _controllerUsername.value.text,
                      //     _controllerPassword.value.text));
                    },
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
