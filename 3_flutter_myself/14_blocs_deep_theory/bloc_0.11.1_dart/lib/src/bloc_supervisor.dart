import 'package:bloc/bloc.dart';

/// Oversees all [Bloc]s and delegates responsibilities to the [BlocDelegate].
///
/// 监督所有[Bloc] 并 将责任委托给[BlocDelegate]。

class BlocSupervisor {
  /// [BlocDelegate] which is notified when events occur in all [Bloc]s.
  /// 当所有 BLoC 事件触发时，BlocDelegate 将会被通知
  BlocDelegate delegate;

  static final BlocSupervisor _singleton = BlocSupervisor._internal();

  factory BlocSupervisor() {
    return _singleton;
  }

  BlocSupervisor._internal();
}
