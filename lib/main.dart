import 'package:flutter/material.dart';
import 'package:pixabay_gallery/app.dart';
import 'package:pixabay_gallery/core/locator/locator.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}
