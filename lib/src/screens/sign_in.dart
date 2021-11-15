import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/register.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class SignInScreen extends StatefulWidget {
  final ValueChanged<Credentials> onSignIn;

  const SignInScreen({
    required this.onSignIn,
    Key? key,
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/SmartCart.png',
              scale: 1.5,
            )
          ),
          Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Sign in', style: Theme.of(context).textTheme.headline4),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: TextButton(
                      onPressed: () async {
                         if(_usernameController.value.text == '' || _passwordController.value.text != '')
                         {
                            error = 'Could not sign in with those credtials';
                         }
                         else{
                          widget.onSignIn(
                            Credentials(
                              _usernameController.value.text,
                              _passwordController.value.text
                            )
                          );
                         }
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: TextButton(
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return registerScreen(

                            );
                          }
                        );
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