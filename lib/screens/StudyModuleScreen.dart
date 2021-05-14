import 'package:flutter/material.dart';
import 'package:we_find/model/modelTranslate.dart';

class StudyModuleScreen extends StatefulWidget {
  final StudyModuleTranslate _studyModule;
  const StudyModuleScreen(this._studyModule);

  @override
  _StudyModuleScreenState createState() => _StudyModuleScreenState();
}

class _StudyModuleScreenState extends State<StudyModuleScreen> {
  Scrollbar _buildStudyModuleScreen(ThemeData themeData) {
    List<Widget> view = [];

    view.add(Text(
      widget._studyModule.getTitle(),
      style: themeData.textTheme.headline3,
    ));
    view.add(Divider());

    for (StudyModuleTranslate eachStudyModule
        in widget._studyModule.getChildren()) {
      view.add(
        Wrap(children: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Course Detail Screen')),
                    body: Center(
                      child: StudyModuleScreen(eachStudyModule),
                    ),
                  );
                }),
              )
            },
            child: Text(
              eachStudyModule.getTitle(),
              style: themeData.textTheme.headline4,
              textAlign: TextAlign.left,
            ),
          ),
        ]),
      );
      view.add(Divider(
        color: themeData.colorScheme.primary,
      ));
    }

    return Scrollbar(
      child: ListView(
        //controller: ScrollController(),
        children: view,
      ),
      showTrackOnHover: true,
      hoverThickness: 10,
      isAlwaysShown: true,
      thickness: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: _buildStudyModuleScreen(themeData),
    );
  }
}
