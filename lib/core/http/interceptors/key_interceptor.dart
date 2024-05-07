import 'package:dio/dio.dart';

class KeyInterceptor extends Interceptor {
  KeyInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.putIfAbsent('key', () => '43732598-c0a2b045cd9c8f36f40c268ed');
    handler.next(options);
  }
}
