import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/login_use_case_bloc.dart';
import '../../business_logic/cubit/counter_activation_cubit.dart';
import '../../const/enums.dart';
import '../../const/events.dart';
import '../../const/states.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_form.dart';
import 'favorite.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
        appBar: AppBar(title: const Text("Login")),
        body: Column(
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
                    context.read<CounterActivationCubit>().increment();
                    return;
                  }

                  context.read<LoginUseCaseBloc>().add(LoginEvent(
                        event: UserActionEvent.click,
                        username: usernameController.controller.text,
                        password: passwordController.controller.text,
                      ));
                },
              ),
            ),
            BlocListener<LoginUseCaseBloc, ApiRequestState>(
              listener: (_, state) {
                switch (state) {
                  case ApiRequestState.success:
                    Navigator.of(context).pushNamed(
                      '/favorite',
                    );
                    break;
                  case ApiRequestState.error:
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid username / password"),
                    ));
                    break;
                  default:
                }
              },
              child: const SizedBox(width: 0, height: 0),
            )
          ],
        ));
  }
}
