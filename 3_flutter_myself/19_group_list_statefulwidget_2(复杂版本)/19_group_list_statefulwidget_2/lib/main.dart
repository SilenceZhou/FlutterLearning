import 'package:flutter/material.dart';
import 'grouped_listview.dart';

import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: ExampleWidget(),
          ),
        ),
      ),
    );
  }
}

class Group {
  String groupName;
  int value;

  Group(this.groupName, this.value);
  @override
  String toString() {
    // TODO: implement toString
    return "groupName = ${this.groupName}, value = ${this.value}";
  }
}

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoupListView<Group, String>(
      collection: [
        Group("Test2", 1),
        Group("Test2", 2),
        Group("Test2", 3),
        Group("Test2", 4),
        Group("Test2", 5),
        Group("Test2", 6),
        Group("Test1", 1),
        Group("Test1", 2),
        Group("Test1", 3),
        Group("Test1", 4),
        Group("Test1", 5),
        Group("Test1", 6),
        Group("Test1", 7),
        Group("Test1", 8),
        Group("Test1", 9),
        Group("Test1", 10),
        Group("Test1", 11),
        Group("Test1", 12),
        Group("Test1", 13),
        Group("Test1", 14),
      ],
      groupBy: (Group g) => g.groupName,
      listBuilder: cell,
      groupBuilder: (BuildContext context, String name) => Container(
            height: 60,
            child: Text(name),
            color: ExtensionColor.random(),
          ),
    );
  }

  Widget cell(BuildContext context, Group g) {
    return InkWell(
      onTap: () {
        print('g = $g');
      },
      child: Container(
        color: ExtensionColor.random(),
        height: 60,
        child: ListTile(title: Text(g.value.toString())),
      ),
    );
  }
}

/// 随机色
class ExtensionColor {
  static final Random _random = new Random();

  /// Returns a random color.
  static Color random() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
