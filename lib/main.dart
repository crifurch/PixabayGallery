import 'package:flutter/material.dart';
import 'package:pixabay_gallery/app.dart';
import 'package:pixabay_gallery/core/http/responses/response_error.dart';
import 'package:pixabay_gallery/core/locator/locator.dart';

void main() async {
  await setupLocator();
  final responseError = ResponseError.fromCode(403);
  print(responseError);
  runApp(const MyApp());
}
