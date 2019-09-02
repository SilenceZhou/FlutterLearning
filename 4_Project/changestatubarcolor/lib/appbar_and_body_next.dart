import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarAndBodyNext extends StatefulWidget {
  @override
  _AppBarAndBodyNextState createState() => _AppBarAndBodyNextState();
}

class _AppBarAndBodyNextState extends State<AppBarAndBodyNext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App bar body next"),
        brightness: Brightness.dark, // 白
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark, // 黑
        child: Container(
          child: Center(
            child: Text("App bar body next"),
          ),
        ),
      ),
    );
  }
}
