import 'package:flutter/material.dart';

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
          child: InkWell(
            onTap: () {
              test();
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Text('Hello World'),
            ),
          ),
        ),
      ),
    );
  }

  /// 数字转换简单， 但是类型转换呢?
  test() {
    num a = 1;
    num b = 1.1;

    // 1.测试runtimeType
    // print('a.runtimeType : ${a.runtimeType}, b.runtimeType : ${b.runtimeType}');
    // print('a = $a, b = $b');

    // 2.测试 r
    // var s = r"In a raw string, even \n isn't \tspecial.";
    // var s2 = "In a raw string, even \n isn't \t\t\tspecial.";
    // print(s);
    // print(s2);

    /// 3.测试只有bool类型变量才能直接用来作为 判空
    // var name = 'Bob';
    // if (name) {
    //   // Conditions must have a static type of 'bool'.
    //   // Prints in JavaScript, not in Dart.
    //   print('You have a name!');
    // }

    /// 4.取负值操作
    // int aa = -10;
    // print(aa);

    /// 5.条件表达式
    bool isbool = true;
    var finalStatus =
        isbool ? '1111' : '2222'; // isbool 如何为YES 返回 1111 ，否则返回 2222
    var finalStatus2 = isbool ?? 'hehee'; // isbool 如何为YES则返回本身 , 不成立则返回 hehee

    print('finalStatus : $finalStatus, finalStatus2 : $finalStatus2');

    // var logger = new Logger('UI');
    // logger.log('Button clicked');
  }
}

class Logger {
  final String name;
  bool mute = false;

  /// 抽象方法一定在抽象类里面
  /// void test();

  // _cache is library-private, thanks to the _ in front
  // of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  /// 工厂构造函数的名称必须与紧邻的类的名称相同。
  // factory logger(String name) { // 不行
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      print(msg);
    }
  }

  void call() {
    var wf = new WannabeFunction();
    var out = wf();
    print('$out');
  }
}

class WannabeFunction {
  // call() {}
  test() {}
  // call(String a, String b, String c) => '$a $b $c!';
}

abstract class AbstractContainer {
  // ...Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}

class SpecializedContainer extends AbstractContainer {
  // ...Define more constructors, fields, methods...

  void updateChildren() {
    // ...Implement updateChildren()...
  }

  // Abstract method causes a warning but
  // doesn't prevent instantiation.

  /// 非抽象类里面不能定义 抽象方法 ---> 是不是和dart的语法有点冲突 还是语法更新了？
  ///
  // void doSomething();
}
