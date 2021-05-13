import 'package:flutter/material.dart';
import 'package:we_find/screens/CourseDetailScreen.dart';
import 'package:we_find/styles/theme.dart' as Theme;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  void _testCourseScreen(context) {}

  @override
  Widget build(BuildContext context) {
    const String WEFIND_TITLE = 'we:find';

    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
          Align(
            child: Text(
              WEFIND_TITLE,
              style: Theme.Text.titleStyle,
            ),
            alignment: Alignment.center,
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          Align(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 40,
              child: Placeholder(), // TODO: Search Bar
            ),
            alignment: Alignment.center,
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
          Align(
            child: SizedBox(
                width: 150,
                height: 150,
                child: ElevatedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.Colors.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                      Align(
                        child: Icon(
                          Icons.menu_book,
                          color: Theme.Colors.accentColor,
                          size: 40,
                        ),
                        alignment: Alignment.center,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      Align(
                        child: Text(
                          'Course Directory',
                          style: Theme.Text.buttonAccentTextStyle,
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                )),
            alignment: Alignment.center,
          ),
          // Is here for now ugly like this as a lambda,
          // as it needs to have access to context.
          // If you know a better way feel free to change it
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Course Detail Screen')),
                    body: Center(
                      child: CourseDetailScreen(),
                    ),
                  );
                }),
              )
            },
            child: Text("Test course screen"),
          ),
        ],
      ),
    );
  }
}
