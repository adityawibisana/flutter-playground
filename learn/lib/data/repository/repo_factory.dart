import 'package:dio/dio.dart';
import 'package:learn/data/provider/voiceping_service.dart';
import 'package:learn/data/repository/dio_network_client.dart';

class SingletonProvider {
  static late final Dio dio = Dio();
  static late final NetworkService networkService = VoicePingService();
  static late final NetworkRepository networkRepository =
      NetworkRepository(dio: dio, networkService: networkService);

  static final SingletonProvider _singleton = SingletonProvider._internal();
  factory SingletonProvider() {
    return _singleton;
  }
  SingletonProvider._internal();

  dynamic get<T>() {
    final typeT = T.toString();
    if (typeT == (Dio).toString()) {
      return dio;
    } else if (typeT == (NetworkService).toString()) {
      return networkService;
    } else if (typeT == (NetworkRepository).toString()) {
      return networkRepository;
    }
    throw Exception("Type of $T has not been instantiated yet.");
  }
}
