import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<String> getToken(Dio dio, String username, String password) {
    throw UnimplementedError();
  }
}

class VoicePingService implements NetworkService {
  final String baseUrl = "https://voiceoverping.net";
  final String clientId = "2359media";
  final String clientSecret = "2359admin";
  final String grantType = "password";

  @override
  Future<String> getToken(Dio dio, String username, String password) async {
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
    return response.toString();
  }
}
