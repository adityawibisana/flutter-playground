import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/login_use_case_bloc.dart';
import '../../business_logic/cubit/counter_activation_cubit.dart';
import '../../data/repository/dio_network_client.dart';
import '../../data/repository/repo_factory.dart';
import '../page/favorite.dart';
import '../page/login.dart';

class AppRouter {
  final LoginUseCaseBloc loginUseCaseBloc =
      LoginUseCaseBloc(SingletonProvider().get<NetworkRepository>());

  final CounterActivationCubit counterActivationCubit =
      CounterActivationCubit();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => loginUseCaseBloc,
            ),
            BlocProvider(
              create: (context) => counterActivationCubit,
            ),
          ], child: const Login()),
        );

      case '/favorite':
        return MaterialPageRoute(
          builder: (_) => const Favorite(),
        );

      default:
        return onGenerateRoute(const RouteSettings(name: "/"));
    }
  }
}
