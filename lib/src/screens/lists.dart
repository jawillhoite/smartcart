import 'package:flutter/material.dart';


class ListsScreen extends StatefulWidget {
  const ListsScreen({Key? key}) : super(key: key);

  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SafeArea(
          child: ListsContent(),
        ),
      );
}

class ListsContent extends StatelessWidget {
  const ListsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GridView.count(
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
                child: Text("List $index"),
              ),
            ),
        );
      }),
    );
  }
}
