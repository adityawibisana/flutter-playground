import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/business_logic/cubit/counter_activation_cubit.dart';
import 'package:learn/const/enums.dart';
import 'package:learn/data/repository/dio_network_client.dart';
import 'package:learn/data/model/base_network_error.dart';
import 'package:learn/data/repository/repo_factory.dart';
import 'package:provider/provider.dart';
import 'data/provider/voiceping_service.dart';
import 'presentation/widget/custom_text_form.dart';
import 'presentation/widget/custom_button.dart';
import 'presentation/widget/material_container.dart';
import 'presentation/page/favorite.dart';

void main() {
  runApp(const MaterialContainer(root: Root()));
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

    final counterActivationCubit = CounterActivationCubit();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocProvider<CounterActivationCubit>(
        create: (_) => counterActivationCubit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            usernameController,
            passwordController,
            BlocBuilder<CounterActivationCubit, ActivationStatus>(
              builder: (context, state) {
                return Visibility(
                  child: routerCountroller,
                  visible: state == ActivationStatus.activated,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  content: "Login",
                  onPressed: () async {
                    if (usernameController.controller.text.isEmpty &&
                        passwordController.controller.text.isEmpty) {
                      counterActivationCubit.increment();
                      return;
                    }

                    final networkRepository =
                        SingletonProvider().get<NetworkRepository>();

                    try {
                      await networkRepository.getToken(
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
      ),
    );
  }
}
