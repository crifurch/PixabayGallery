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
  static const _collapseLimit = 350;

  ///needs for debouncing
  Timer? _timer;
  bool _showLargeSearchField = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode(debugLabel: 'searchField');

  @override
  void initState() {
    super.initState();
    _node.addListener(() {
      if (_showLargeSearchField && !_node.hasFocus) {
        setState(() => _showLargeSearchField = false);
      }
    });
  }

  @override
  void dispose() {
    _node.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (_showLargeSearchField) {
            _showLargeSearchField = constraints.maxWidth < _collapseLimit;
          } else if (constraints.maxWidth < _collapseLimit && _node.hasFocus) {
            _showLargeSearchField = true;
          }
          return FractionallySizedBox(
            heightFactor: 0.9,
            widthFactor: 0.98,
            child: Row(
              children: [
                if (!_showLargeSearchField) ...[
                  FractionallySizedBox(
                    heightFactor: 0.8,
                    child: Image.asset(Res.icAppIcon),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Pixabay Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ],
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.7,
                    alignment: _showLargeSearchField ? Alignment.center : Alignment.centerRight,
                    child: constraints.maxWidth < _collapseLimit && !_showLargeSearchField
                        ? InkWell(
                            onTap: () {
                              setState(() => _showLargeSearchField = true);
                              _node.requestFocus();
                            },
                            child: const Icon(
                              Icons.search_outlined,
                              shadows: [
                                BoxShadow(offset: Offset(0.1, 0.1)),
                              ],
                            ),
                          )
                        : TextField(
                            controller: _controller,
                            focusNode: _node,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Search',
                            ),
                            onChanged: _onChangeSearchQuery,
                          ),
                  ),
                ),
              ],
            ),
          );
        },
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
