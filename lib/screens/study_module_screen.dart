import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/widgets/study_module_widget.dart';

class StudyModuleScreen extends StatefulWidget {
  final StudyModuleWrapped _studyModule;
  const StudyModuleScreen(this._studyModule);

  @override
  _StudyModuleScreenState createState() => _StudyModuleScreenState();
}

class _StudyModuleScreenState extends State<StudyModuleScreen> {
  String _trimName(String name) {
    if (name.endsWith(')')) {
      return name.substring(0, name.lastIndexOf('('));
    }
    return name;
  }

  ListView _buildStudyModuleScreen(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    view.add(Text(
      widget._studyModule.title,
      style: themeData.textTheme.headline3,
    ));
    view.add(Divider());

    for (StudyModuleWrapped eachStudyModule
        in widget._studyModule.children) {
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
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        child: _buildStudyModuleScreen(context),
      ),
    );
  }
}
