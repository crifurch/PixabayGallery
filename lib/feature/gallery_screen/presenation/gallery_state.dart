part of 'gallery_bloc.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    @Default(true) bool isLoading,
    @Default(false) bool isAdditionalLoading,
    @Default(0) loadedPages,
    @Default([]) List<PixabayImage> images,
    @Default(null)String? query,
    @Default(false) allLoaded,
  }) = _RunGameState;
}
