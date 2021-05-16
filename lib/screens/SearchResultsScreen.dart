import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/model/modelWrapped.dart';
import 'package:we_find/providers/lang_provider.dart';
import 'package:we_find/widgets/CourseWidget.dart';

class SearchResultsScreen extends StatelessWidget {
  final BuildContext _context;
  final List<CourseWrapped> _myCourses = [];
  final String _searchQuery;

  SearchResultsScreen(this._context, List<Course> courses, this._searchQuery) {
    final langProvider = Provider.of<LangProvider>(_context);
    final currentLang = langProvider.currentLang;
    for (Course eachCourse in courses) {
      // TODO: CHANGE THE LANGUAGE TO SOMETHING MEANINGFULL!
      _myCourses.add(CourseWrapped(eachCourse, currentLang));
    }
  }

  ListView _buildSearchResults(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    view.add(Text(
      "Search results for: $_searchQuery", // TODO: LANGUAGE
      style: themeData.textTheme.headline2,
    ));
    view.add(Divider());

    for (CourseWrapped eachCourse in _myCourses) {
      view.add(CourseWidget(eachCourse));
      view.add(Divider());
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
