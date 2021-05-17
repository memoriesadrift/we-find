import 'package:flutter/material.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/widgets/course_widget.dart';

class SearchResultsScreen extends StatelessWidget {
  final String _searchQuery;
  final List<Course> _courses;

  SearchResultsScreen(this._searchQuery, this._courses);

  ListView _buildSearchResults(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    view.add(Text(
      "Search results for: $_searchQuery", // TODO: LANGUAGE
      style: themeData.textTheme.headline2,
    ));
    view.add(Divider());

    _courses.forEach((course) {
      final courseWrapped = CourseWrapped(context, course);
      view.add(CourseWidget(courseWrapped));
      view.add(Divider());
    });

    if (_courses.isEmpty) {
      view.add(Text(
        "No results found!",
        style: themeData.textTheme.headline2,
      ));
    }

    return ListView(
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Scrollbar(
        child: _buildSearchResults(context),
      ),
    );
  }
}
