import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/models/pixabay_image.dart';

part 'pixabay_page.g.dart';

@JsonSerializable()
class PixabayPage {
  final int totalHits;
  final List<PixabayImage> hits;

  PixabayPage({
    required this.totalHits,
    required this.hits,
  });

  factory PixabayPage.fromJson(Map<String, dynamic> json) => _$PixabayPageFromJson(json);
}
