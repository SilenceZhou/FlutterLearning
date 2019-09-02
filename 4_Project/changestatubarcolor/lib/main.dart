import 'package:changestatubarcolor/router.dart';
import 'package:changestatubarcolor/second_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'first_page_appbar.dart';
// import 'firt_page_no_appbar.dart';
// import 'second_page_appbar.dart';
// import 'second_page_no_appbar.dart';
// import 'appbar_and_body.dart';
// import 'appbar_and_body_next.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(),
      routes: Router.routers(context),
      initialRoute: Router.homePage,
    );
  }
}

// class FirstPage extends StatefulWidget {
//   FirstPage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _FirstPageState createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title + "111"),
//         brightness: Brightness.light, // 白
//       ),
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light, // 黑
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'You have pushed the button this many times:',
//               ),
//               Text(
//                 '$_counter',
//                 style: Theme.of(context).textTheme.display1,
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SecondPage()));
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.arrow_right),
//       ),
//     );
//   }
// }
