import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pixabay_gallery/core/http/dio.dart';
import 'package:pixabay_gallery/core/http/interceptors/key_interceptor.dart';
import 'package:pixabay_gallery/core/http/interceptors/log_interceptor.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/pixabay_repository.dart';
import 'package:pixabay_gallery/feature/gallery_screen/presenation/gallery_bloc.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  locator
    ..registerSingleton(Logger())
    ..registerSingleton(CustomLogInterceptor(locator.get()))
    ..registerSingleton(KeyInterceptor())
    ..registerSingleton(DioProvider(
      logInterceptor: locator.get(),
      keyInterceptor: locator.get(),
    ));

  await _initRepositories();
  await _initBlocs();
}

Future<void> _initRepositories() async {
  locator.registerFactory(() => PixabayRepository(locator.get<DioProvider>().pixabayApi));
}

Future<void> _initBlocs() async {
  locator.registerFactory(() => GalleryBloc(pixabayRepository: locator.get()));
}
