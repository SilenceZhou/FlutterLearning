import 'package:bloc/bloc.dart';

/// 监督所有[Bloc] 并 将责任委托给[BlocDelegate]。

class BlocSupervisor {
  /// 当所有 BLoC 事件触发时，BlocDelegate 将会被通知
  BlocDelegate delegate;

  static final BlocSupervisor _singleton = BlocSupervisor._internal();

  factory BlocSupervisor() {
    return _singleton;
  }

  BlocSupervisor._internal();
}
