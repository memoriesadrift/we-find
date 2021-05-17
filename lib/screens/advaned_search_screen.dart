import 'package:flutter/material.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/screens/search_results_screen.dart';
import 'package:we_find/service/ufind_queries.dart';
import 'package:we_find/service/ufind_service.dart';
import 'package:we_find/widgets/advanced_search_widgets.dart';
import 'package:we_find/widgets/search_bar.dart';

class AdvancedSearchScreen extends StatefulWidget {
  @override
  _AdvancedSearchScreenState createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  bool _fuzzy = true;
  bool _ustream = false;
  bool _currentTerm = false;
  final _onlyInTerm = SemesterInputAccesser();
  final _fromTerm = SemesterInputAccesser();
  final _toTerm = SemesterInputAccesser();

  Container _buildAdvancedOptions(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final StringConstants constants = StringConstants(context);

    List<Widget> view = [];
    view.add(CustomCheckbox(_fuzzy, constants.FuzzySearch,
        (bool? e) => setState(() => _fuzzy = !_fuzzy)));
    view.add(CustomCheckbox(_ustream, constants.CourseWithStream,
        (bool? e) => setState(() => _ustream = !_ustream)));
    view.add(CustomCheckbox(_currentTerm, constants.OnlyCurrentTerm,
        (bool? e) => setState(() => _currentTerm = !_currentTerm)));

    if (!_currentTerm) {
      view.add(Text(
        constants.SearchByTerm,
        style: themeData.textTheme.headline3,
      ));
      view.add(SemesterInput(_onlyInTerm));
      view.add(Divider(color: themeData.colorScheme.primary));
      view.add(Text(
        constants.SearchByTermRange,
        style: themeData.textTheme.headline3,
      ));
      view.add(Text(
        constants.FromTerm,
        style: themeData.textTheme.headline4,
      ));
      view.add(SemesterInput(_fromTerm));
      view.add(Divider(
        indent: double.infinity,
      ));
      view.add(Text(
        constants.ToTerm,
        style: themeData.textTheme.headline4,
      ));
      view.add(SemesterInput(_toTerm));
    }

    return Container(
      child: Column(
        children: view,
      ),
    );
  }

  List<QueryArgument> _getQueryArgs() {
    List<QueryArgument> ret = [];

    if (!_fuzzy) {
      ret.add(Exact);
    }
    if (_ustream) {
      ret.add(OffersUStream);
    }
    if (_currentTerm) {
      ret.add(CurrentTerm);
    }
    if (_onlyInTerm.text != "") {
      ret.add(InSemester(_onlyInTerm.text + _onlyInTerm.semester));
    } else if (_fromTerm.text != "") {
      String from = _fromTerm.text + _fromTerm.semester;
      String to;
      if (_fromTerm.text == "") {
        to = currentTerm();
      } else {
        to = _fromTerm.text + _fromTerm.semester;
      }
      ret.add(SemesterRange(from, to));
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    final StringConstants constants = StringConstants(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SearchBar(
            barWidth: double.infinity,
            barHeight: 80,
            key: Key('advancedSearchScreenSearchBar'),
            callbackFunction: (String input) => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(title: Text(constants.SearchResults)),
                  body: Center(
                    child: FutureBuilder<List<Course>>(
                      future: queryForCourses(
                        input,
                        queryArgs: _getQueryArgs(),
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.data != null) {
                          return SearchResultsScreen(input, snapshot.data!);
                        }
                        throw Exception("don't you dare throw this!");
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
          _buildAdvancedOptions(context),
        ],
      ),
    );
  }
}
