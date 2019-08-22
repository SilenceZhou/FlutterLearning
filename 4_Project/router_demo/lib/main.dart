import 'package:flutter/material.dart';
import 'first_page.dart';
import 'router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: FirstPage(),
      routes: Router.routes,
    );
  }
}
