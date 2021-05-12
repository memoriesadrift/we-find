import 'package:flutter/material.dart';
import 'package:we_find/screens/CourseDetailScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Stuff'),
        leading: Icon(Icons.home),
      ),
      body: CourseDetailScreen(),
    );
  }
}
