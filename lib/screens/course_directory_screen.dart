import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/widgets/course_directory_widgets.dart';

class CourseDirectoryScreen extends StatefulWidget {
  final List<StudyModuleWrapped> _root;
  const CourseDirectoryScreen(this._root);

  @override
  _CourseDirectoryScreenState createState() => _CourseDirectoryScreenState();
}

class _CourseDirectoryScreenState extends State<CourseDirectoryScreen> {
  ListView _buildStudyModuleScreen(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    view.add(Text(
      "Course Directory", // TODO: LANGUAGE
      style: themeData.textTheme.headline2,
    ));
    view.add(Divider());

    for (StudyModuleWrapped eachStudyModule in widget._root) {
      view.add(CourseDirectoryStudyModuleRootWidget(eachStudyModule));
      view.add(Divider(
        color: themeData.colorScheme.primary,
      ));
    }

    return ListView(
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        child: _buildStudyModuleScreen(context),
      ),
    );
  }
}
