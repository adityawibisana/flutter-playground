import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn/data/repository/dio_network_client.dart';
import 'package:learn/data/model/base_network_error.dart';
import 'package:provider/provider.dart';
import 'presentation/widget/custom_text_form.dart';
import 'presentation/widget/custom_button.dart';
import 'presentation/widget/material_container.dart';
import 'presentation/page/favorite.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HiddenFieldCounter(),
    child: const MaterialContainer(root: Root()),
  ));
}

class HiddenFieldCounter with ChangeNotifier {
  int clickCount = 0;

  void increment() {
    clickCount++;
    notifyListeners();
  }
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = CustomTextForm(title: "Username");
    final passwordController = CustomTextForm(
      title: "Password",
      isPassword: true,
    );

    final routerCountroller = CustomTextForm(title: "Router");
    routerCountroller.controller.text =
        "wss://2359media-router.voiceoverping.net";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          usernameController,
          passwordController,
          Consumer<HiddenFieldCounter>(
            builder: (context, hiddenFieldCounter, child) => Visibility(
              child: routerCountroller,
              visible: hiddenFieldCounter.clickCount >= 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                content: "Login",
                onPressed: () async {
                  if (usernameController.controller.text.isEmpty &&
                      passwordController.controller.text.isEmpty) {
                    var counter = context.read<HiddenFieldCounter>();
                    counter.increment();
                    return;
                  }

                  var network = DioNetworkService();
                  try {
                    await network.getToken(
                      usernameController.controller.text,
                      passwordController.controller.text,
                    );
                  } catch (e) {
                    var exception = e as DioError;
                    var error = BaseNetworkError.fromJson(
                        jsonDecode(exception.response.toString()));
                    if (error.message.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error.message),
                      ));
                    }
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Favorite(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
