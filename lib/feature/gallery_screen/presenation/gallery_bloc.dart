import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/models/pixabay_image.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/pixabay_repository.dart';

part 'gallery_bloc.freezed.dart';

part 'gallery_event.dart';

part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final PixabayRepository _pixabayRepository;

  GalleryBloc({
    required PixabayRepository pixabayRepository,
  })  : _pixabayRepository = pixabayRepository,
        super(const GalleryState()) {
    on<GalleryEvent>((event, emit) => event.when<Future<void>>(
          init: () => _init(emit),
          loadNextPage: () => _loadNextPage(emit),
          search: (query) => _search(query, emit),
        ));
  }

  Future<void> _init(Emitter<GalleryState> emit) async => _search('', emit);

  Future<void> _loadNextPage(Emitter<GalleryState> emit) async {
    if (state.allLoaded || state.isAdditionalLoading) {
      return;
    }
    emit(state.copyWith(isAdditionalLoading: true));
    emit((await _loadPage(state)).copyWith(isAdditionalLoading: false));
  }

  Future<void> _search(String query, Emitter<GalleryState> emit) async {
    emit(state.copyWith(
      loadedPages: 0,
      isLoading: true,
      query: query,
      images: [],
      allLoaded: false,
    ));
    emit((await _loadPage(state)).copyWith(isLoading: false));
  }

  Future<GalleryState> _loadPage(GalleryState state) async {
    final images = await _pixabayRepository.getImages(
      searchRequest: state.query,
      page: state.loadedPages,
      perPage: 20,
    );
    if (!images.isSuccess || images.castedData == null) {
      return state;
    }
    final list = [...state.images, ...?images.castedData?.hits];
    final galleryState = state.copyWith(
      images: list,
      loadedPages: state.loadedPages + 1,
      allLoaded: list.length >= images.castedData!.totalHits,
    );
    return galleryState;
  }
}
