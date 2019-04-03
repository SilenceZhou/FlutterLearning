import 'package:flutter/material.dart';

/// 声明周期 参考： https://segmentfault.com/a/1190000015211309
/// https://juejin.im/entry/5b213b9de51d45069c2f11f3
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LuanchPage(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => new MyHomePage(),
        "/luanchPage": (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class LuanchPage extends StatefulWidget {
  @override
  _LuanchPageState createState() => _LuanchPageState();
}

class _LuanchPageState extends State<LuanchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LuanchPage'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('点击我就好'),
          onPressed: () {
            Navigator.of(context).pushNamed("/home");
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('-----------didChangeAppLifecycleState');
    switch (state) {
      case AppLifecycleState.inactive:
        // 进入 paused和resumed之前必须经过的状态
        print('-----------AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
        // -- 处于后台状态
        //当应用程序处于此状态时，引擎将不会调用 [Window.onBeginFrame]和[Window.onDrawFrame]回调。
        print('-----------AppLifecycleState.paused');
        break;

      case AppLifecycleState.resumed:
        // -- 处于恢复状态 (处于前台)
        // 应用程序处于非活动状态，并且未接收用户输入。
        print('-----------AppLifecycleState.resumed');
        break;
      case AppLifecycleState.suspending: // iOS 没用到
        print('-----------AppLifecycleState.suspending');
        break;
      default:
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    print('----------------initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    ///  调用顺序：initState -> didChangeDependencies -> build
    ///
    ///当[State]对象的依赖关系发生更改时调用。
    /// 例如，如果先前对[build]的调用引用了稍后更改的[InheritedWidget]， 则框架将调用此方法以通知此对象有关更改。
    /// 在[initState]之后也会立即调用此方法。从此方法调用[BuildContext.inheritFromWidgetOfExactType]是安全的。
    /// 子类很少覆盖此方法，因为框架在依赖项更改后始终调用[build]。
    /// 一些子类确实覆盖了这种方法，因为当它们的依赖关系发生变化时，它们需要做一些昂贵的工作（例如，网络提取），并且这种工作对于每个构建来说都太昂贵了。

    print('---------------didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget

    /// 当组件的状态改变的时候就会调用didUpdateWidget,比如调用了setState.
    /// 代码调整触发, 横竖屏切换触发

    print('----------------didUpdateWidget');

    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    /// 在dispose之前，会调用这个函数。
    print('----------------deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('----------------dispose');
  }

  Widget center() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    print('----------------build');
    return Scaffold(
      appBar: AppBar(
        title: Text("home page"),
      ),
      body: center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
