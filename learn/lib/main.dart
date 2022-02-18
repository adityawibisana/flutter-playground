import 'package:flutter/material.dart';
import 'package:learn/dio_network_client.dart';
import 'custom/custom_text_form.dart';
import 'custom/custom_button.dart';
import 'pages/favorite.dart';

void main() {
  runApp(const MyApp());
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

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const CustomTextForm(title: "Username"),
          const CustomTextForm(title: "Password"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                content: "Login",
                onPressed: () async {
                  var network = DioNetworkService();
                  await network.getToken(
                    "",
                    "",
                  );
                }),
          ),
        ],
      ),
    );
  }
}
