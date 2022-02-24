import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learn/data/model/login.dart';

class DioNetworkService {
  final String baseUrl = "https://voiceoverping.net";
  final String clientId = "2359media";
  final String clientSecret = "2359admin";
  final String grantType = "password";

  static final Dio dio = Dio();

  static final DioNetworkService _network = DioNetworkService._internal();
  factory DioNetworkService() {
    return _network;
  }
  DioNetworkService._internal();

  Future<Login> getToken(String username, String password) async {
    var response = await dio.post(
      '$baseUrl/v2/oauth/token',
      data: {
        'username': username,
        'password': password,
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': grantType,
      },
    );
    return Login.fromJson(jsonDecode(response.toString()));
  }
}
