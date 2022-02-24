import 'package:flutter/material.dart';

import '../widget/material_container.dart';

void main() {
  runApp(const MaterialContainer(root: Favorite()));
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
