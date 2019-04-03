import 'package:bloc/bloc.dart';

/// Handles events from all [Bloc]s
/// which are delegated by the [BlocSupervisor].
/// 
/// 处理来自所有[Bloc]的事件
/// 由[BlocSupervisor]委托。
class BlocDelegate {
  /// Called whenever a transition occurs with the given [Transition] in any [Bloc].
  /// A [Transition] occurs when a new [Event] is dispatched and `mapEventToState` executed.
  /// `onTransition` is called before a [Bloc]'s state has been updated.
  /// A great spot to add universal logging/analytics.
  /// 
  /// 在任何[Bloc]中使用给定[Transition]发生转换时调用。
  /// 当 新的[Event]被分发(dispatched)并且执行`mapEventToState`时 发生 转换 [Transition]。
  /// `onTransition`在[Bloc]的状态更新之前被调用。
  /// 添加通用日志记录/分析的好地方。
  ///
  void onTransition(Transition transition) => null;

  /// Called whenever an [Exception] is thrown within `mapEventToState` for any [Bloc].
  /// The stacktrace argument may be `null` if the state stream received an error without a [StackTrace].
  /// A great spot to add universal error handling.
  /// 
  /// 无论何时在任何一个bloc中的mapEventToState 抛出 Exception，onError都会被调用。
  /// 如果状态流在没有[StackTrace]的情况下收到错误，则stacktrace参数可以是“null”。
  /// 添加通用错误处理的好地方。
  void onError(Object error, StackTrace stacktrace) => null;
}
