import 'package:dio/dio.dart';

import 'api_paths.dart';

/// This class is used to configure the Dio instance
/// and to create a singleton instance of the Dio class
class ApiConfig {
  static final ApiConfig _singleton = ApiConfig._internal();
  factory ApiConfig() => _singleton;

  late Dio dio;

  ApiConfig._internal() {
    //creates the singleton instance
    dio = Dio();
    // Set default configs
    dio.options.baseUrl = ApiPaths.baseURL;
    dio.options.connectTimeout = const Duration(milliseconds: 10000); //10s
    dio.options.receiveTimeout = const Duration(milliseconds: 10000); //10s
  }
}
