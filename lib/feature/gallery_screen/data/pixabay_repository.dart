import 'package:dio/dio.dart';
import 'package:pixabay_gallery/core/http/responses/complex_response.dart';
import 'package:pixabay_gallery/core/http/responses/handled_response.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/models/pixabay_page.dart';

class PixabayRepository {
  final Dio _client;

  PixabayRepository(this._client);

  Future<ComplexResponse<PixabayPage>> getImages({
    String searchRequest = '',
    int page = 0,
    int perPage = 50,
  }) async {
    try {
      final result = await _client.get('', queryParameters: {
        'q': searchRequest,
        'page': page + 1,
        'per_page': perPage,
      });
      return ComplexResponse.converted(
        HandledResponse.fromDioResult(result),
        converter: (data) {
          if (!data.containsKey('hits')) {
            return null;
          }
          return PixabayPage.fromJson(data);
        },
      );
    } on Exception catch (e) {
      return ComplexResponse(HandledResponse.fromException(e));
    }
  }
}
