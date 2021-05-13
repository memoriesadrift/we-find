import 'package:flutter/material.dart';

class GroupDetails extends StatelessWidget {
  /* TODO: Uncomment this once this class exists
   * final Group _myGroup;
   * const GroupDetails(this._myGroup);
  */

  // _buildLecturersList(Lecturers[] lecturers)
  // _buildTimeTable(TimeTableEntry[] timeTable)

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // subtitle
          Text(
            "Max participants:" + ' ' + "42",
            style: themeData.textTheme.headline3,
          ),
          // build lecturers list
          //_buildLecturersList(Lecturers[] lecturers),
          // subtitle
          Text(
            "Group information:",
            style: themeData.textTheme.headline3,
          ),
          // regular text
          SelectableText(
            "Sample Course info1234567897 alalallalalalal." +
                "Should be able to copy from here!",
            style: themeData.textTheme.bodyText1,
          ),
          //_buildTimeTable(TimeTableEntry[] timeTable)
        ],
      ),
    );
  }
}
