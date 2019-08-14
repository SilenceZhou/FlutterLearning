import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'example4.dart';
import 'scaffold_wrapper.dart';
import 'example1.dart';
import 'example2.dart';
import 'example3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Headers Example',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: 'Sticky Headers Example',
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: <Widget>[
            ListTile(
              title: const Text('Example 1 - Headers and Content'),
              onTap: () => navigateTo(context, (context) => Example1()),
            ),
            ListTile(
              title: const Text('Example 2 - Animated Headers with Content'),
              onTap: () => navigateTo(context, (context) => Example2()),
            ),
            ListTile(
              title: const Text('Example 3 - Headers overlapping the Content'),
              onTap: () => navigateTo(context, (context) => Example3()),
            ),
            ListTile(
              title: const Text('Example 4 - Sticy refresh'),
              onTap: () => navigateTo(context, (context) => Example4()),
            ),
          ],
        ).toList(growable: false),
      ),
    );
  }

  navigateTo(BuildContext context, builder(BuildContext context)) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }
}
