import 'dart:async'; // StreamController

import 'package:flutter/material.dart';

class IncrementBloc implements BlocBase {
  /// 计数器 对外流出的对象
  int _counter;

  /// Stream来处理计数器
  /// 1. 定义一个Controller
  StreamController<int> _counterController = StreamController<int>();

  /// 2. 获取 StreamSink 做 add 入口
  StreamSink<int> get _inAdd => _counterController.sink;

  /// 3. 获取 Stream 用于监听 -- 对外
  Stream<int> get outCounter => _counterController.stream;

  //  Stream来处理计数器上的操作
  StreamController _actionController = StreamController();

  /// 对外
  StreamSink get incrementCounter => _actionController.sink;

  //
  // Constructor
  //
  IncrementBloc() {
    /// 初始化
    _counter = 0;

    /// 监听事件
    _actionController.stream.listen(_handleLogic);
  }

  void dispose() {
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(data) {
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }
}

Type _typeOf<T>() => T;

//所有BLoC的通用接口
abstract class BlocBase {
  void dispose();
}

/// 升级的地方为： 即在原来 StatefulWidget 的 child 外面再包了一个 InheritedWidget
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();

    /// 当然这也是源于 Fluter Framework 缓存了所有 InheritedWidgets 才得以实现
    /// 时间复杂度为O(1)
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
