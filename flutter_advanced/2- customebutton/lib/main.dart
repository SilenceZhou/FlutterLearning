import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // 主动调用 setState 会触发 build方法，这样就会更新界面元素 和 值
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized (优化) to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),

      floatingActionButton: MyButton(
        onTap: _incrementCounter,
        toolTip: 'Increment',
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// 再点击的时候会看到一个蒙层怎么去掉
class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  MyButton({this.onTap, this.toolTip});

  final String toolTip;

  @override
  Widget build(BuildContext context) {
    return new Material(
      // 如果要在控件外面添加圆角则需要Material
      borderRadius: new BorderRadius.circular(40),
      shadowColor: Colors.grey,
      elevation: 5.0,
      color: Colors.red, // 直接设置外面的按钮就好
      child: InkWell(
          onTap: onTap,
          child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(16.0),
              //color: Colors.red, // 如果里面还设置颜色就看不到圆角了
              child: Tooltip(
                message: toolTip,
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white70,
                ),
              ))),
    );
  }
}

class MyButton2 extends StatelessWidget {
  final VoidCallback onTap;
  MyButton2({this.onTap, this.toolTip});

  final String toolTip;

  @override
  Widget build(BuildContext context) {
    return new Material(
        // 如果要在控件外面添加圆角则需要Material
        borderRadius: new BorderRadius.circular(40),
        shadowColor: Colors.grey,
        elevation: 5.0,
        color: Colors.red, // 直接设置外面的按钮就好
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(16.0),
              //color: Colors.red, // 如果里面还设置颜色就看不到圆角了
              child: Tooltip(
                message: toolTip,
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white70,
                ),
              )),
        ));
  }
}
