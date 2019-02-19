import 'package:flutter/material.dart';


class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new CounterIncrementor(onPressed: _increment),
      new CounterDisplay(count: _counter),
    ]);
  }
}

// // 使用Material组件
// void main() {
//   runApp(new MaterialApp(
//     title: 'Flutter Tutorial',
//     home: new TutorialHome(),
//   ));
// }

// class TutorialHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //Scaffold是Material中主要的布局组件.
//     return new Scaffold(
//       appBar: new AppBar(
//         leading: new IconButton(
//           icon: new Icon(Icons.menu),
//           tooltip: 'Navigation menu',
//           onPressed: null,
//         ),
//         title: new Text('Example title'),
//         actions: <Widget>[
//           new IconButton(
//             icon: new Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: null,
//           ),
//         ],
//       ),
//       //body占屏幕的大部分
//       body: new Center(
//         child: new Text('Hello, world!'),
//       ),
//       /// 具体怎么监测
//       floatingActionButton: new FloatingActionButton(
//         tooltip: 'Add', // used by assistive technologies
//         child: new Icon(Icons.add),
//         onPressed: null,
//       ),
//     );
//   }
// }

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new GestureDetector(
//       onTap: () {
//         print('MyButton was tapped!');
//       },
//       child: new Container(
//         height: 36.0,
//         padding: const EdgeInsets.all(8.0),
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         decoration: new BoxDecoration(
//           borderRadius: new BorderRadius.circular(5.0),
//           color: Colors.lightGreen[500],
//         ),
//         child: new Center(
//           child: new Text('Engage'),
//         ),
//       ),
//     );
//   }
// }

// ------------------------------------------
// 不使用Material组件
// class MyAppBar extends StatelessWidget {
//   MyAppBar({this.title});

//   // Widget子类中的字段往往都会定义为"final"

//   final Widget title;

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       height: 56.0, // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: new BoxDecoration(color: Colors.blue[500]),
//       // Row 是水平方向的线性布局（linear layout）
//       child: new Row(
//         //列表项的类型是 <Widget>
//         children: <Widget>[
//           new IconButton(
//             icon: new Icon(Icons.menu),
//             tooltip: 'Navigation menu',
//             onPressed: null, // null 会禁用 button
//           ),
//           // Expanded expands its child to fill the available space.
//           new Expanded( //  中间的title widget被标记为Expanded,
//             child: title,
//           ),
//           new IconButton(
//             icon: new Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: null,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyScaffold extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Material 是UI呈现的“一张纸”
//     return new Material(
//       // Column is 垂直方向的线性布局.
//       child: new Column(
//         children: <Widget>[
//           new MyAppBar(
//             title: new Text(
//               'Example title',
//               style: Theme.of(context).primaryTextTheme.title,
//             ),
//           ),
//           new Expanded(
//             child: new Center(
//               child: new Text('Hello, world!'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(new MaterialApp(
//     title: 'My app', // used by the OS task switcher
//     home: new MyScaffold(),
//   ));
// }