import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/models/pixabay_image.dart';

class ImagePreview extends StatelessWidget {
  final PixabayImage image;
  final dynamic animationId;

  const ImagePreview({
    super.key,
    required this.image,
    this.animationId,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: animationId??image.id,
                child: CachedNetworkImage(
                  imageUrl: image.previewURL,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.remove_red_eye_outlined,
                shadows: [
                  BoxShadow(offset: Offset(0.06, 0.06)),
                ],
              ),
              Text(
                image.views.toString(),
                maxLines: 1,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                image.likes.toString(),
                maxLines: 1,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.favorite_outline,
                shadows: [
                  BoxShadow(offset: Offset(0.1, 0.1)),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
