import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/widgets/study_module_widget.dart';

class CourseDirectoryScreen extends StatefulWidget {
  final StudyModuleWrapped _studyModule;
  const CourseDirectoryScreen(this._studyModule);

  @override
  _CourseDirectoryScreenState createState() => _CourseDirectoryScreenState();
}

class _CourseDirectoryScreenState extends State<CourseDirectoryScreen> {
  String _trimName(String name) {
    if (name.startsWith("Studienprogrammleitung") ||
        name.startsWith("Directorate of Studies"))
      return name.substring(name.indexOf(" ") + 1);
    return name;
  }

  ListView _buildStudyModuleScreen(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    view.add(Text(
      "Course Directory", // TODO: LANGUAGE
      style: themeData.textTheme.headline2,
    ));
    view.add(Divider());

    for (StudyModuleWrapped eachStudyModule
        in widget._studyModule.getChildren()) {
      view.add(StudyModuleWidget(eachStudyModule, _trimName));
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
