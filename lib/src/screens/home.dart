import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('TEMP HOME LIST')),),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: .75,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        padding: const EdgeInsets.all(15),
        children: List.generate(10, (index) {
          return FractionallySizedBox(
            heightFactor: 1,
              child: Card(
                child: Center (
                  child: Text("Item $index"),
                ),
              ),
          );
        }),
      ),
    );
  }
}
