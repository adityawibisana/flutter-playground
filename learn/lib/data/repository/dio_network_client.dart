import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learn/data/model/login.dart';
import 'package:learn/data/provider/voiceping_service.dart';

class NetworkRepository {
  final Dio dio;
  final NetworkService networkService;

  NetworkRepository({
    required this.dio,
    required this.networkService,
  });

  Future<Login> getToken(String username, String password) async {
    var apiResult = await networkService.getToken(dio, username, password);
    final decoded = jsonDecode(apiResult);
    return Login.fromJson(decoded);
  }
}
