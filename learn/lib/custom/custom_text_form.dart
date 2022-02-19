import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm({Key? key, required this.title}) : super(key: key);

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: title,
        ),
      ),
    );
  }
}
