import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  final Widget child;
  final String title;

  const ScaffoldWrapper({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: 'app_bar',
          child: AppBar(
            title: Text(title),
            elevation: 0.0,
          ),
        ),
      ),
      body: child,
    );
  }
}
