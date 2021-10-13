import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SafeArea(
          child: HomeContent(),
        ),
      );
}

class HomeContent extends StatelessWidget {
  const HomeContent({
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
        return const FractionallySizedBox(
          heightFactor: 1,
            child: Card(
              child: Center (
                child: Text("Testing"),
              ),
            ),
        );
      }),
    );
  }
}
