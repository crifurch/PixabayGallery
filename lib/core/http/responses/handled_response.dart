// ignore_for_file: unnecessary_import

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_gallery/core/http/responses/response_error.dart';
import 'package:pixabay_gallery/core/http/responses/server_response.dart';

@immutable
class HandledResponse extends ServerResponse {
  final String friendlyMessage;
  final String error;

  const HandledResponse(
    super.code, {
    this.friendlyMessage = '',
    this.error = '',
    super.data,
  });

  factory HandledResponse.fromDioError(DioException dioError) {
    if (dioError.error is SocketException) {
      return const HostUnavailableError();
    }
    if (dioError.response == null) {
      return const UnknownError();
    }
    return HandledResponse.fromDioResult(dioError.response!);
  }

  factory HandledResponse.noContent() => const HandledResponse(204);

  factory HandledResponse.fromDioResult(
    Response dioResponse,
  ) {
    HandledResponse response;
    if (dioResponse.data == null) {
      response = HandledResponse(
        dioResponse.statusCode ?? 0,
      );
    } else if (dioResponse.data is Map<String, dynamic>) {
      response = HandledResponse(
        dioResponse.statusCode ?? 0,
        data: dioResponse.data,
      );
    } else {
      response = HandledResponse(
        dioResponse.statusCode ?? 0,
        data: {'data': dioResponse.data},
      );
    }
    if (response.isSuccess) {
      return response;
    }
    final data = response.data;
    switch (dioResponse.statusCode) {
      case 401:
        return UserNotAuthorized(
          error: data?['error']?.toString() ?? '',
        );
      case 422:
        return ValidationError(
          error: data?['error']?.toString() ?? '',
        );
      case 403:
        return ForbiddenError(
          error: data?['error']?.toString() ?? '',
        );
      case 406:
        return NotAcceptableError(
          error: data?['error']?.toString() ?? '',
        );
      default:
        return UnknownError(code: dioResponse.statusCode ?? 0);
    }
  }

  factory HandledResponse.fromException(Exception exception) {
    if (exception is DioException) {
      return HandledResponse.fromDioError(exception);
    }
    return HandledResponse(
      0,
      friendlyMessage: exception.toString(),
    );
  }
}
