import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.extra['start_at'] = DateTime.now().millisecondsSinceEpoch;
    final m = {
      'uri': options.uri,
      'method': options.method,
      'headers': options.headers,
      'body': (options.data is FormData)
          ? options.data.fields.map((e) => '${e.key}:${e.value}').join('\n')
          : options.data.toString(),
    };

    Logger().i(
      '*** Request ***\n${m.entries.map((e) => '${e.key}:${e.value}').join('\n')}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final startAt = response.requestOptions.extra['start_at'] as int?;
    final duration = (startAt != null)
        ? DateTime.now().millisecondsSinceEpoch - startAt
        : null;
    final m = {
      'uri': response.requestOptions.uri,
      'duration': '$duration ms',
      'statusCode': response.statusCode,
      'headers': response.headers,
      'body': response.data,
    };
    if (response.isRedirect == true) {
      m['redirect'] = response.realUri;
    }
    Logger().i(
      '*** Response ***\n${m.entries.map((e) => '${e.key}:${e.value}').join('\n')}',
    );

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final startAt = err.requestOptions.extra['start_at'] as int?;
    final duration = (startAt != null)
        ? DateTime.now().millisecondsSinceEpoch - startAt
        : null;
    Logger().e(
      '*** DioException ***\n'
      'duration: ${duration != null ? '$duration ms' : 'N/A'}\n'
      'uri: ${err.requestOptions.uri}\n'
      'statusCode: ${err.response?.statusCode}\n'
      'headers: ${err.response?.headers}\n'
      'body: ${err.response?.data}\n'
      '$err'
      '${err.response != null ? err.response!.data : ''}',
    );
    handler.next(err);
  }
}
