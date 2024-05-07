// ignore_for_file: avoid_catches_without_on_clauses

import 'package:dio/dio.dart';
import 'package:pixabay_gallery/core/http/interceptors/key_interceptor.dart';
import 'package:pixabay_gallery/core/http/interceptors/log_interceptor.dart';

/// DioProvider is class that configure Dio clients 
class DioProvider {
  final CustomLogInterceptor _logInterceptor;
  final KeyInterceptor _keyInterceptor;

  DioProvider({
    required CustomLogInterceptor logInterceptor,
    required KeyInterceptor keyInterceptor,
  })  : _logInterceptor = logInterceptor,
        _keyInterceptor = keyInterceptor {
    _configureDio();
  }

  final Dio _dio = Dio();

  BaseOptions get _options => BaseOptions(
        baseUrl: 'https://pixabay.com/api/',
        connectTimeout: const Duration(seconds: 10),
        listFormat: ListFormat.multiCompatible,
      );

  void _configureDio() {
    _dio.options = _options;
    _dio.interceptors.addAll([
      _keyInterceptor,
      _logInterceptor,
    ]);
  }

  Dio get pixabayApi => _dio;
}
