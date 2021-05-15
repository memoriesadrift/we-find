import 'package:flutter/material.dart';
import 'package:we_find/model/modelWrapped.dart';
import 'package:we_find/widgets/StudyModuleWidget.dart';

import 'StudyModuleScreen.dart';

// TODO: This is just a copy of StudyModuleScreen with some changes
// if you know how to fix this feel free.

class CourseDirecotryScreen extends StatefulWidget {
  final StudyModuleWrapped _studyModule;
  const CourseDirecotryScreen(this._studyModule);

  @override
  _CourseDirecotryScreenState createState() => _CourseDirecotryScreenState();
}

class _CourseDirecotryScreenState extends State<CourseDirecotryScreen> {
  String _trimName(String name) {
    if (name.startsWith("Studienprogrammleitung") ||
        name.startsWith("Directorate of Studies"))
      return name.substring(name.indexOf(" ") + 1);
    return name;
  }

  ListView _buildStudyModuleScreen(ThemeData themeData) {
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
    final ThemeData themeData = Theme.of(context);
    return Scrollbar(
      isAlwaysShown: true,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        child: _buildStudyModuleScreen(themeData),
      ),
    );
  }
}
