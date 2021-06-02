import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/widgets/info_tooltip.dart';

class CustomCheckboxRow extends StatelessWidget {
  final CustomCheckbox _customCheckbox;
  final String _info;

  CustomCheckboxRow(this._customCheckbox, this._info);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_customCheckbox, InfoTooltip(_info)],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool _ticked;
  final String _text;
  final void Function(bool?) _onPressed;

  const CustomCheckbox(this._ticked, this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: _ticked,
            onChanged: _onPressed,
          ),
          Text(_text),
        ],
      ),
    );
  }
}

class SemesterInputAccesser extends TextEditingController {
  String semester = "WS";
}

class SemesterInput extends StatefulWidget {
  final SemesterInputAccesser _accesser;

  const SemesterInput(this._accesser);

  @override
  _SemesterInputState createState() => _SemesterInputState();
}

class _SemesterInputState extends State<SemesterInput> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> semester = [];
    semester.add(DropdownMenuItem<String>(
      child: Text("WS"),
      onTap: () => setState(() => widget._accesser.semester = "WS"),
      value: "WS",
    ));
    semester.add(DropdownMenuItem<String>(
      child: Text("SS"),
      onTap: () => setState(() => widget._accesser.semester = "SS"),
      value: "SS",
    ));

    final StringConstants constants = StringConstants(context);

    return Container(
      child: Row(
        children: [
          Text("${constants.TermYear}: "),
          Container(
            width: 50,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: widget._accesser,
            ),
          ),
          Text("${constants.WinterSummerTerm}: "),
          DropdownButton<String>(
            value: widget._accesser.semester,
            items: semester,
            onChanged: (String? returned) =>
                setState(() => widget._accesser.semester = returned!),
          )
        ],
      ),
    );
  }
}
