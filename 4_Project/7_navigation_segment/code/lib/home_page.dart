import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  final Widget child;

  HomePage({Key key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(title),
      ),
    );
  }
}
