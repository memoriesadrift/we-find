import 'package:flutter/material.dart';
import 'package:we_find/styles/theme.dart' as Theme;

class GroupDetails extends StatelessWidget {
  /* TODO: Uncomment this once this class exists
   * final Group _myGroup;
   * const GroupDetails(this._myGroup);
  */

  // _buildLecturersList(Lecturers[] lecturers)
  // _buildTimeTable(TimeTableEntry[] timeTable)

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // subtitle
          Text(
            "Max participants:" + ' ' + "42",
            style: Theme.Text.heading3Style,
          ),
          // build lecturers list
          //_buildLecturersList(Lecturers[] lecturers),
          // subtitle
          Text(
            "Group information:",
            style: Theme.Text.heading3Style,
          ),
          // regular text
          SelectableText(
            "Sample Course info1234567897 alalallalalalal." +
                "Should be able to copy from here!",
            style: Theme.Text.textStyle,
          ),
          //_buildTimeTable(TimeTableEntry[] timeTable)
        ],
      ),
    );
  }
}
