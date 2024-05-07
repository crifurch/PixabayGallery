import 'package:dio/dio.dart';
/// KeyInterceptor is class that add pixabay api key in all request from Dio clients that are using this interceptor
class KeyInterceptor extends Interceptor {
  KeyInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //in value of 'key' is your api key, this key provided only for tests
    options.queryParameters.putIfAbsent('key', () => '43732598-c0a2b045cd9c8f36f40c268ed');
    handler.next(options);
  }
}
