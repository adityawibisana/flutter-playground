import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn/dio_network_client.dart';
import 'package:learn/entities/base_network_error.dart';
import 'package:provider/provider.dart';
import 'custom/custom_text_form.dart';
import 'custom/custom_button.dart';
import 'pages/favorite.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HiddenFieldCounter(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue),
      home: const Root(),
    );
  }
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
