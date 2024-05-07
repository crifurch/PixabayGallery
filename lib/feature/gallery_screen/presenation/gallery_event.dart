part of 'gallery_bloc.dart';

@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.init() = _Init;

  const factory GalleryEvent.loadNextPage() = _LoadNextPage;

  const factory GalleryEvent.search(String query) = _Search;
}
