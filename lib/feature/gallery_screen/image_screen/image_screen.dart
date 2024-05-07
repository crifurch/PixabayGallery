import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/models/pixabay_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ImageScreen extends StatelessWidget {
  final PixabayImage image;
  final dynamic animationId;

  const ImageScreen({
    super.key,
    required this.image,
    this.animationId,
  });

  @override
  Widget build(BuildContext context) {
    const infoColor = Colors.white;
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: infoColor,
    );
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Material(
        color: Colors.grey.withOpacity(
          0.8,
        ),
        child: Stack(
          children: [
            Center(
              child: FractionallySizedBox(
                heightFactor: 0.85,
                child: Hero(
                  tag: animationId ?? image.id,
                  //prevent close on image tap
                  child: GestureDetector(
                    onTap: () {},
                    child: CachedNetworkImage(
                      placeholder: (context, url) => CachedNetworkImage(
                        imageUrl: image.previewURL,
                        fit: BoxFit.contain,
                      ),
                      imageUrl: image.largeImageURL,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.08,
                widthFactor: 0.6,
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: Text(
                          image.tags.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: textStyle,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: infoColor,
                            shadows: [
                              BoxShadow(
                                color: infoColor,
                                offset: Offset(0.06, 0.06),
                              ),
                            ],
                          ),
                          Text(
                            image.views.toString(),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: textStyle,
                          ),
                          const SizedBox(width: 10),
                          const Spacer(),
                          InkWell(
                            // open pixabay page to download image
                            onTap: () => launchUrlString(image.pageURL),
                            child: const Icon(
                              Icons.save_alt_outlined,
                              color: infoColor,
                              shadows: [
                                BoxShadow(
                                  color: infoColor,
                                  offset: Offset(0.1, 0.1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            image.likes.toString(),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: textStyle,
                          ),
                          const Icon(
                            Icons.favorite_outline,
                            color: infoColor,
                            shadows: [
                              BoxShadow(
                                color: infoColor,
                                offset: Offset(0.1, 0.1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
