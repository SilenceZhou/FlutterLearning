import 'package:flutter/material.dart';
import 'forsted_glass_demo.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'silenzhou',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home:Scaffold(
        body: ForstedClassDemo(),
      )
    );
  }
}