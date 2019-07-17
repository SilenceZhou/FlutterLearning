import 'package:meta/meta.dart';

/// 在调用`mapEventToState`之后但在[Bloc]的[State]更新之前调度[Event]时发生。
/// [Transition]由`currentState`，`event`和`nextState`组成.`event`是`dispatched`。
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

  /// Dart 里的 String 跟 Java 中的一样，是不可变对象；不同的是，检测两个 String 的内容是否一样事，我们使用 == 进行比较；
  /// 如果要测试两个对象是否是同一个对象（indentity test），使用 identical 函数
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transition<Event, State> &&
          runtimeType == other.runtimeType &&
          currentState == other.currentState &&
          event == other.event &&
          nextState == other.nextState;

  @override
  int get hashCode =>
      currentState.hashCode ^ event.hashCode ^ nextState.hashCode;

  @override
  String toString() =>
      'Transition { currentState: $currentState, event: $event, nextState: $nextState }';
}
