import 'package:dio/dio.dart';
import 'package:flutter_project_template/network/interceptors/log_interceptor.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();

  late final Dio _dio;

  factory DioProvider() => _instance;

  DioProvider._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.travel.taipei',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    )..interceptors.add(LoggerInterceptor());
  }

  static Dio get dio => _instance._dio;
}
