import 'package:flutter/material.dart';
import 'package:we_find/model/modelTranslate.dart';

class StudyModuleScreen extends StatefulWidget {
  final StudyModuleTranslate _studyModule;
  const StudyModuleScreen(this._studyModule);

  @override
  _StudyModuleScreenState createState() => _StudyModuleScreenState();
}

class _StudyModuleScreenState extends State<StudyModuleScreen> {
  ListView _buildStudyModuleScreen(ThemeData themeData) {
    List<Widget> view = [];

    view.add(Text(
      widget._studyModule.getTitle(),
      style: themeData.textTheme.headline3,
    ));

    for (StudyModuleTranslate eachStudyModule
        in widget._studyModule.getChildren()) {
      view.add(Text(
        eachStudyModule.getTitle(),
        style: themeData.textTheme.headline4,
      ));
    }

    return ListView(
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      child: _buildStudyModuleScreen(themeData),
    );
  }
}
