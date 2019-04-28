import 'package:meta/meta.dart';

/// Occurs when an [Event] is `dispatched` after `mapEventToState` has been called
/// but before the [Bloc]'s [State] has been updated.
/// A [Transition] consists of the `currentState`, the `event` which was `dispatched`, and the `nextState`.
///
/// 当 event 被分发(dispatched) 后，但在[Bloc]的[State]更新之前调度[Event]时发生。
/// 转换（Transition）由currentState，已分派的事件(event)和 nextState组成。
class Transition<Event, State> {
  final State currentState;
  final Event event;
  final State nextState;

  const Transition({
    @required this.currentState,
    @required this.event,
    @required this.nextState,
  })  : assert(currentState != null),
        assert(event != null),
        assert(nextState != null);

  /// 重写操作符
  /// identical : 检查两个引用是否属于同一对象。
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transition<Event, State> &&
          runtimeType == other.runtimeType &&
          currentState == other.currentState &&
          event == other.event &&
          nextState == other.nextState;

  /// hash值由三者 组合
  @override
  int get hashCode =>
      currentState.hashCode ^ event.hashCode ^ nextState.hashCode;

  /// 重写toString 便于打印的时候查看信息
  @override
  String toString() =>
      'Transition { currentState: $currentState, event: $event, nextState: $nextState }';
}
