import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pixabay_gallery/res.dart';

class GallerySearchBar extends StatefulWidget {
  final void Function(String query)? onSearch;

  const GallerySearchBar({
    super.key,
    this.onSearch,
  });

  @override
  State<GallerySearchBar> createState() => _GallerySearchBarState();
}

class _GallerySearchBarState extends State<GallerySearchBar> {
  ///needs for debouncing
  Timer? _timer;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Row(
              children: [
                FractionallySizedBox(
                  heightFactor: 0.8,
                  child: Image.asset(Res.icAppIcon),
                ),
                const SizedBox(width: 30),
                const Text(
                  'Pixabay Gallery',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.7,
                alignment: Alignment.centerRight,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                  onChanged: _onChangeSearchQuery,
                ),
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      );

  void _onChangeSearchQuery(String value) {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer(const Duration(milliseconds: 800), () {
      _timer = null;
      widget.onSearch?.call(value);
    });
  }
}
