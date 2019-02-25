import 'package:flutter/material.dart';
import 'search_bar_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'search demo',
      theme: ThemeData.light(),
      home: SearchBarDemo(),
    );
  }
}