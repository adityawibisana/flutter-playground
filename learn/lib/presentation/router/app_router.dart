import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/login_use_case_bloc.dart';
import '../../business_logic/cubit/counter_activation_cubit.dart';
import '../../data/repository/dio_network_client.dart';
import '../../data/repository/repo_factory.dart';
import '../page/login.dart';
import '../widget/material_container.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginUseCaseBloc(
                    SingletonProvider().get<NetworkRepository>()),
              ),
              BlocProvider(
                create: (context) => CounterActivationCubit(),
              ),
            ],
            child: const MaterialContainer(root: Login()),
          ),
        );

      default:
        return onGenerateRoute(const RouteSettings(name: "/"));
    }
  }
}
