import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'second_page.dart';
import 'router.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FlutterBoost.singleton.registerPageBuilders({
      Router.homePage: (pageName, params, _) => HomePage(),
      Router.secondPage: (pageName, params, _) => SecondPage(),
    });

    FlutterBoost.handleOnStartPage();
  }

  Map<String, WidgetBuilder> routes = {
    Router.homePage: (BuildContext context) => HomePage(),
    Router.secondPage: (BuildContext context) => SecondPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      builder: FlutterBoost.init(),
      home: HomePage(),
      // home: Container(),
      routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text('push second page'),
            onPressed: () {
              print("flutter 页面进行push");
              Navigator.of(context).pushNamed(Router.secondPage);
            },
          ),
        ),
      ),
    );
  }
}
