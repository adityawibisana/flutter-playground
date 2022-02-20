import 'package:flutter/material.dart';

void main() {
  runApp(const FavoriteDirectRunner());
}

class FavoriteDirectRunner extends StatelessWidget {
  const FavoriteDirectRunner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Favorite(),
    );
  }
}

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
    );
  }
}
