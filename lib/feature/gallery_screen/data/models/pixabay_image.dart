import 'package:json_annotation/json_annotation.dart';

part 'pixabay_image.g.dart';

@JsonSerializable()
class PixabayImage {
  int id;
  String pageURL;
  String previewURL;
  String largeImageURL;
  String tags;
  int likes;
  int views;

  PixabayImage({
    required this.id,
    required this.pageURL,
    required this.previewURL,
    required this.largeImageURL,
    required this.tags,
    required this.likes,
    required this.views,
  });

  factory PixabayImage.fromJson(Map<String, dynamic> json) => _$PixabayImageFromJson(json);
}
