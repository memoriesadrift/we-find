import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:we_find/language/language_constants.dart';
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
    for (int i = 0; i < widget._groups.length; ++i) {
      items.add(DropdownMenuItem(
        child: Text(_extractNumberFromId(widget._groups[i].id)),
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
    final StringConstants constants = StringConstants(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Text(constants.SelectAGroup),
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

  Column _buildGroupDetails(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final StringConstants constants = StringConstants(context);

    List<Widget> view = [];

    // Max participants
    view.add(Padding(
      child: Text(
        "${constants.MaxParticipants}: " + _group.maxParticipants,
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));

    // Description
    view.add(Padding(
      child: Text(
        "${constants.GroupInformation}:",
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));
    // has to be wrapped in html widget,
    // as it can contain html tags
    view.add(
      Html(
        data: _group.description,
        style: {
          "body": Style(
            fontSize: FontSize(18),
          )
        },
      ),
    );

    // Dates
    view.add(Padding(
      child: Text(
        "${constants.Schedule}:",
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));
    try {
      view.add(EventCalendar(_group.schedule));
    } catch (e) {
      // do nothing
    }

    // Minimum requirements
    view.add(Padding(
      child: Text(
        "${constants.MinimumRequierments}:",
        style: themeData.textTheme.headline4,
      ),
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
    ));
    view.add(Html(data: _group.minumumRequirements));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildGroupDetails(context),
    );
  }
}

class EventCalendar extends StatelessWidget {
  final ScheduleWrapped _schedule;

  const EventCalendar(this._schedule);

  Row _eventToWidget(EventWrapped event) {
    return Row(
      children: [
        Expanded(
          child: Text(event.fullEventDate),
        ),
        Expanded(
          child: Text(event.room),
        )
      ],
    );
  }

  Column _buildEventCalendar() {
    List<Widget> view = [];

    for (EventWrapped event in _schedule.events) {
      view.add(_eventToWidget(event));
      view.add(Divider());
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
