import 'package:dio/dio.dart';
import 'package:flutter_project_template/network/interceptors/log_interceptor.dart';

class DioProvider {
  static DioProvider? _instance;

  late final Dio _dio;

  DioProvider._internal({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    )..interceptors.add(LoggerInterceptor());
  }

  /// 全域初始化，由外部傳入 [baseUrl]。
  static DioProvider init({required String baseUrl}) {
    _instance = DioProvider._internal(baseUrl: baseUrl);
    return _instance!;
  }

  /// 取得單例實例。若尚未呼叫 [init]，將拋出 [StateError]。
  static DioProvider get instance {
    final inst = _instance;
    if (inst == null) {
      throw StateError(
        'DioProvider has not been initialized. Please call DioProvider.init(baseUrl: ...) first.',
      );
    }
    return inst;
  }

  /// 依據風格規範提供靜態 getter `I`
  static DioProvider get I => instance;

  /// 取得全域單例所持有的 [Dio] 實例
  static Dio get dio => instance._dio;
}
