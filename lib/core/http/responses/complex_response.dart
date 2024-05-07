import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pixabay_gallery/core/http/responses/handled_response.dart';
import 'package:pixabay_gallery/core/http/responses/response_error.dart';
import 'package:pixabay_gallery/core/http/responses/server_response.dart';

@immutable
/// ComplexResponse is subclass of HandledResponse that contain converted object from body of response
/// you can use [ComplexResponse.converted] to provide converter
class ComplexResponse<T> extends HandledResponse {
  final T? castedData;

  ServerResponse get successResponse => this;

  ResponseError get errorResponse => asError;

  ComplexResponse(HandledResponse response, {this.castedData})
      : super(
          response.code,
          friendlyMessage: response.friendlyMessage,
          error: response.error,
          data: response.data,
        );

  ComplexResponse.converted(
    HandledResponse response, {
    T? Function(Map<String, dynamic> data)? converter,
  }) : this(
          response,
          castedData:
              response.data != null ? converter?.call(response.data!) : null,
        );

  ComplexResponse.fromDioError(DioException dioError)
      : this(HandledResponse.fromDioError(dioError));

  ComplexResponse.fromDioResult(
    Response<Map<String, dynamic>> dioResponse, {
    T? Function(Map<String, dynamic> data)? converter,
  }) : this(
          HandledResponse.fromDioResult(dioResponse),
          castedData: dioResponse.data == null
              ? null
              : converter?.call(dioResponse.data!),
        );

  ComplexResponse.fromException(Exception exception)
      : this(HandledResponse.fromException(exception));
}
