import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/business_logic/bloc/login_use_case_bloc.dart';
import 'package:learn/business_logic/cubit/counter_activation_cubit.dart';
import 'package:learn/const/enums.dart';
import 'package:learn/const/events.dart';
import 'package:learn/const/states.dart';
import 'package:learn/data/repository/dio_network_client.dart';
import 'package:learn/data/repository/repo_factory.dart';
import 'package:learn/presentation/router/app_router.dart';
import 'presentation/widget/custom_text_form.dart';
import 'presentation/widget/custom_button.dart';
import 'presentation/widget/material_container.dart';
import 'presentation/page/favorite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute);
  }
}
