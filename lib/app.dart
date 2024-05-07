import 'package:flutter/material.dart';
import 'package:pixabay_gallery/core/locator/locator.dart';
import 'package:pixabay_gallery/feature/gallery_screen/gallery_screen.dart';
import 'package:pixabay_gallery/feature/gallery_screen/presenation/gallery_bloc.dart';
import 'package:pixabay_gallery/feature/gallery_screen/widgets/search_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Pixabay Gallery',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Pixabay Gallery'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final GalleryBloc _galleryBloc;

  @override
  void initState() {
    _galleryBloc = locator.get();
    _galleryBloc.add(const GalleryEvent.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: GallerySearchBar(
            onSearch: (query) => _galleryBloc.add(GalleryEvent.search(query)),
          ),
        ),
        body: GalleryScreen(
          galleryBloc: _galleryBloc,
        ),
      );
}
