import 'package:flutter/material.dart';

class InfoTooltip extends StatelessWidget {
  final String info;

  InfoTooltip(this.info);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Tooltip(
      message: info,
      child: ClipOval(
        child: Material(
          color: themeData.primaryColor,
          child: InkWell(
            splashColor: themeData.accentColor,
            child: SizedBox(
              width: 32,
              height: 32,
              child: Icon(
                Icons.info_outline,
                color: themeData.accentColor,
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
