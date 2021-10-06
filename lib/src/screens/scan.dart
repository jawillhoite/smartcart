import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../routing.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    child: ScanContent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class ScanContent extends StatelessWidget {
  const ScanContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ...[
            Text(
              'Scan',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                ShoppingListAuthScope.of(context).signOut();
              },
              child: const Text('Sign out'),
            ),
            Link(
              uri: Uri.parse('/book/0'),
              builder: (context, followLink) => TextButton(
                onPressed: followLink,
                child: const Text('Go directly to /book/0 (Link)'),
              ),
            ),
            TextButton(
              child: const Text('Go directly to /book/0 (RouteState)'),
              onPressed: () {
                RouteStateScope.of(context).go('/book/0');
              },
            ),
          ].map((w) => Padding(padding: const EdgeInsets.all(8), child: w)),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Alert!'),
                content: const Text('The alert description goes here.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text('Show Dialog'),
          )
        ],
      );
}