import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  double barWidth;
  double barHeight;
  Function callbackFunction;
  SearchBar(
      {required Key key,
      this.barWidth = (100),
      this.barHeight = (40),
      required this.callbackFunction})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final int cacheSize = 4;
  List<String> searchCache = [];
  List<String> typeAheadCache = [];
  String searchQuery = '';
  final inputController = TextEditingController();

  void updateCache(String query) {
    if (searchCache.contains(query)) {
      searchCache.removeWhere((e) => e == query);
    }

    searchCache.add(query);
    updateTypeAhead(query);
  }

  void updateTypeAhead(String query) {
    if (query == '') {
      typeAheadCache = searchCache;
      return;
    }
    typeAheadCache = searchCache.where((e) => e.startsWith(query)).toList();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: widget.barWidth,
          height: widget.barHeight,
          child: TextField(
            controller: inputController,
            onChanged: (text) {
              setState(() {
                searchQuery = text;
                updateTypeAhead(text);
              });
            },
            onSubmitted: (text) {
              setState(() {
                searchQuery = text;
                updateCache(text);
              });
              widget.callbackFunction(text);
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search for a course...'),
          ),
        ),
      ),
    );
  }
}
