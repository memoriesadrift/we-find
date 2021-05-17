import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/widgets/course_directory_widgets.dart';

class StudyModuleScreen extends StatefulWidget {
  final StudyModuleWrapped _studyModule;
  const StudyModuleScreen(this._studyModule);

  @override
  _StudyModuleScreenState createState() => _StudyModuleScreenState();
}

class _StudyModuleScreenState extends State<StudyModuleScreen> {
  ListView _buildStudyModuleScreen(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    view.add(Text(
      widget._studyModule.title,
      style: themeData.textTheme.headline3,
    ));
    view.add(Divider());

    if (widget._studyModule.children.isNotEmpty) {
      for (StudyModuleWrapped eachStudyModule in widget._studyModule.children) {
        view.add(CourseDirectoryStudyModuleWidget(eachStudyModule));
        view.add(Divider(
          color: themeData.colorScheme.primary,
        ));
      }
    } else if (widget._studyModule.courses.isNotEmpty) {
      for (CourseWrapped eachCourse in widget._studyModule.courses) {
        view.add(CourseDirectoryCourseWidget(eachCourse));
        view.add(Divider(
          color: themeData.colorScheme.primary,
        ));
      }
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
