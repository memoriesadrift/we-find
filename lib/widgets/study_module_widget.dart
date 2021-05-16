import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/screens/study_module_screen.dart';

class StudyModuleWidget extends StatelessWidget {
  final StudyModuleWrapped _myStudyModule;
  final Function? _trimName;
  const StudyModuleWidget(this._myStudyModule, this._trimName);

  String _getTrimmedTitle(String title) {
    if (_trimName == null) {
      return title;
    }
    return _trimName!(title);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      child: Wrap(
        children: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Course Detail Screen')),
                    body: Center(
                      child: StudyModuleScreen(_myStudyModule),
                    ),
                  );
                }),
              )
            },
            child: Container(
              width: double.infinity, // 100% width of parent
              child: Text(
                _getTrimmedTitle(_myStudyModule.getTitle()),
                style: themeData.textTheme.headline4,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
