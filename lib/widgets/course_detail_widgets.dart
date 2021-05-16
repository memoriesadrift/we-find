import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:we_find/model/i18n_string.dart';
import 'package:we_find/model/model_wrapped.dart';

class GroupPicker extends StatefulWidget {
  final List<GroupWrapped> _groups;

  const GroupPicker(this._groups);

  @override
  _GroupPickerState createState() => _GroupPickerState();
}

class _GroupPickerState extends State<GroupPicker> {
  int _showingGroupIndex = 0;

  String _extractNumberFromId(String id) {
    return id.substring(id.indexOf('-') + 1);
  }

  DropdownButton<int> _buildDropDownButton() {
    List<DropdownMenuItem<int>> items = [];
    // TODO: Check if this behaves correctly. For example PR1 has a group 99
    // which this would not detect
    for (int i = 0; i < widget._groups.length; ++i) {
      items.add(DropdownMenuItem(
        child: Text(_extractNumberFromId(widget._groups[i].getId())),
        onTap: () => setState(() => _showingGroupIndex = i),
        value: i,
      ));
    }
    return DropdownButton(
      value: _showingGroupIndex,
      items: items,
      onChanged: (int? returned) =>
          setState(() => _showingGroupIndex = returned!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Text("Select a group"),
            Spacer(),
            _buildDropDownButton()
          ]),
          GroupDetails(widget._groups[_showingGroupIndex]),
        ],
      ),
    );
  }
}

class GroupDetails extends StatelessWidget {
  final GroupWrapped _group;
  const GroupDetails(this._group);

  Column _buildGroupDetails(ThemeData themeData) {
    Lang currentLang = Lang.DE;
    Lang fallbackLang = Lang.EN;

    List<Widget> view = [];

    // Max participants
    view.add(Padding(
      child: Text(
        "Max participants: " + _group.getMaxParticipants(),
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));

    // Description
    view.add(Padding(
      child: Text(
        "Group information:",
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));
    // has to be wrapped in html widget,
    // as it can contain html tags
    view.add(Html(
      data: _group.getDescription(),
    ));

    // Dates
    view.add(Padding(
      child: Text(
        "Schedule:",
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));
    try {
      view.add(EventCalendar(_group.getSchedule()));
    } catch (e) {
      // do nothing
    }

    // Minimum requirements
    view.add(Padding(
      child: Text(
        "Minumum requierements:",
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
    ));
    view.add(Html(data: _group.getMinumumRequirements()));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      //height: 1000,
      child: _buildGroupDetails(themeData),
    );
  }
}

class EventCalendar extends StatelessWidget {
  final ScheduleWrapped _schedule;
  const EventCalendar(this._schedule);

  Row _eventToWidget(EventWrapped event) {
    return Row(
      children: [
        Text(event.getDate() +
            " " +
            event.getBeginHour() +
            "-" +
            event.getEndHour()),
        Spacer(),
        Text(event.getRoom())
      ],
    );
  }

  Column _buildEventCalendar() {
    List<Row> view = [];

    for (EventWrapped event in _schedule.getEvents()) {
      view.add(_eventToWidget(event));
    }

    return Column(
      children: view,
      mainAxisSize: MainAxisSize.min,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildEventCalendar(),
    );
  }
}
