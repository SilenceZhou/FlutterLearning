import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';

//// 状态管理方案： Redux、Scoped Model、Bloc、Provide、StatefulWidget
///  Provide: 谷歌出品
///  参考链接: https://mp.weixin.qq.com/s/8VoRA0aE128wKnUq-uRJWA

void main() {
  var counter = Counter();
  var providers = Providers(); // 此处为Providers
  providers..provide(Provider<Counter>.value(counter));
  // 多个状态管理
  // providers
  // ..provide(Provider<Counter>.value(counter))
  // ..provide(Provider<Counter>.value(counter));

  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('provide state manager'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Number(),
            MyButton(),
            RaisedButton(
              child: Text('push to second page'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1,
          );
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increase();
        },
        child: Text('递增'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Container(
          child: Provide<Counter>(
            builder: (context, child, counter) {
              return Text('${counter.value}');
            },
          ),
        ),
      ),
    );
  }
}
