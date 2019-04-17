import 'package:flutter/material.dart';
import 'grouped_listview.dart';

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
}

class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<Group, String>(
      collection: [
        Group("Test1", 1),
        Group("Test2", 2),
        Group("Test1", 3),
        Group("Test1", 3),
        Group("Test1", 4),
        Group("Test1", 5),
        Group("Test1", 6),
      ],
      groupBy: (Group g) => g.groupName,
      listBuilder: (BuildContext context, Group g) =>
          ListTile(title: Text(g.value.toString())),
      groupBuilder: (BuildContext context, String name) => Text(name),
    );
  }
}
