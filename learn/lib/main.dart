import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/business_logic/bloc/login_use_case_bloc.dart';
import 'package:learn/business_logic/cubit/counter_activation_cubit.dart';
import 'package:learn/const/enums.dart';
import 'package:learn/const/events.dart';
import 'package:learn/const/states.dart';
import 'package:learn/data/repository/dio_network_client.dart';
import 'package:learn/data/repository/repo_factory.dart';
import 'presentation/widget/custom_text_form.dart';
import 'presentation/widget/custom_button.dart';
import 'presentation/widget/material_container.dart';
import 'presentation/page/favorite.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CounterActivationCubit>(
      create: (BuildContext context) => CounterActivationCubit(),
    ),
    BlocProvider<LoginUseCaseBloc>(
      create: (BuildContext context) =>
          LoginUseCaseBloc(SingletonProvider().get<NetworkRepository>()),
    ),
  ], child: const MaterialContainer(root: Root())));
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Favorite(),
                      ),
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
