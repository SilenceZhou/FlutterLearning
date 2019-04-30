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

//// ================================
/// 所有BLoC的通用接口
abstract class BlocBase {
  void dispose();
}

//通用BLoC提供商
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();

    // 时间复杂度为O(n) 它会沿着视图树从当前 context 开始逐步往上递归查找其 parent 是否符合指定类型。如果当前 context 和目标 ancestor 相距不远的话这种方式还可以接受，否则应该尽量避免使用。
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);

    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override

  /// 便于资源的释放
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
