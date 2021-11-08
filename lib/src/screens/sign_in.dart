import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'register.dart';
//import 'package:smartcart/lib/src/auth.dart';

// class Credentials {
//   final String username;
//   final String password;

//   Credentials(this.username, this.password);
// }

class SignInScreen extends StatefulWidget {
  // final ValueChanged<Credentials> onSignIn;

  // const SignInScreen({
  //   required this.onSignIn,
  //   Key? key,
  // }) : super(key: key);
  final Function toggleView;
  SignInScreen({this.toggleView});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //FireBase sql
  //final AuthService _auth = AuthService()

  String email = '';
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset(
                'assets/images/SmartCart.png',
                scale: 1.5,
              )),
          Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Sign in', style: Theme.of(context).textTheme.headline4),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    controller: _passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: TextButton(
                      onPressed: () async {
                        print(email);
                        print(password);
                        //dynamic result = await _auth.signInAnon();
                        // widget.onSignIn(Credentials(
                        //     _usernameController.value.text,
                        //     _passwordController.value.text));
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: TextButton(
                      onPressed: () async {
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return createAccountScreen();
                        //     });
                      },
                      child: const Text('Create Account'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
