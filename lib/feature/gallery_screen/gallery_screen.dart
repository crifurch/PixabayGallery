import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay_gallery/feature/gallery_screen/data/models/pixabay_image.dart';
import 'package:pixabay_gallery/feature/gallery_screen/image_screen/image_screen.dart';
import 'package:pixabay_gallery/feature/gallery_screen/presenation/gallery_bloc.dart';
import 'package:pixabay_gallery/feature/gallery_screen/widgets/image_preview.dart';

class GalleryScreen extends StatefulWidget {
  final GalleryBloc galleryBloc;

  const GalleryScreen({
    super.key,
    required this.galleryBloc,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GalleryBloc, GalleryState>(
        bloc: widget.galleryBloc,
        builder: (bloc, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.images.isEmpty) {
            return const Center(
              child: Text(
                "Pixabay doesn't have any images matching your request.\nTry change search query to find any image.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          }

          //that need to trigger PostFrameCallback if user only change width of window
          return LayoutBuilder(
            builder: (context, constraints) {
              //check if content height less than screen height and try load more page
              if (!state.isAdditionalLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_controller.hasClients &&
                      _controller.position.maxScrollExtent - _controller.position.pixels < 30) {
                    widget.galleryBloc.add(const GalleryEvent.loadNextPage());
                  }
                });
              }
              return NotificationListener<ScrollNotification>(
                child: GridView.extent(
                  controller: _controller,
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    ...state.images.map(
                      (e) {
                        final animationId = state.images.indexOf(e);
                        return InkWell(
                          onHover: (event) => _onImageHover(context, e),
                          onTap: () => _onImageTap(context, e, animationId),
                          child: ImagePreview(
                            image: e,
                            animationId: animationId,
                          ),
                        );
                      },
                    ),
                    if (state.isAdditionalLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.9) {
                    widget.galleryBloc.add(const GalleryEvent.loadNextPage());
                  }
                  return true;
                },
              );
            },
          );
        },
      );

  void _onImageHover(BuildContext context, PixabayImage image) {
    precacheImage(CachedNetworkImageProvider(image.largeImageURL), context);
  }

  void _onImageTap(BuildContext context, PixabayImage image, [animationId]) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: RouteSettings(
          name: image.id.toString(),
        ),
        opaque: false,
        pageBuilder: (_, __, ___) => ImageScreen(
          image: image,
          animationId: animationId,
        ),
      ),
    );
  }
}
