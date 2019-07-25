// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Provider<Counter>.value( /// 这种是错误的
    return ChangeNotifierProvider<Counter>.value(
      value: Counter(),
      child: Consumer<Counter>(
        builder: (context, counter, _) {
          return MaterialApp(
            home: const MyHomePage(),
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(builder: (_) => Counter()),
  //     ],
  //     child: Consumer<Counter>(
  //       builder: (context, counter, _) {
  //         return MaterialApp(
  //           home: const MyHomePage(),
  //         );
  //       },
  //     ),
  //   );
  // }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.count}',
              style: Theme.of(context).textTheme.display1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: const Text('push'),
            ),
            RaisedButton(
              onPressed: counter.increment,
              child: const Icon(Icons.add),
            ),
            RaisedButton(
              onPressed: counter.decrement,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Text(
          '${Provider.of<Counter>(context).count}',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
