import 'dart:async';

import '../dart_bloc/dart_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// Takes a [Stream] of [Event]s as input
/// and transforms them into a [Stream] of [State]s as output.
/// 需要Event流(stream)的作为输入，并将其变换成State流(Stream)作为输出。
abstract class Bloc<Event, State> {
  /// 利用了RxDart
  /// PublishSubject:普通的广播StreamController,仅向监听器发送在订阅之后添加到Stream的事件
  /// 完全像普通的广播StreamController有一个例外：`stream`返回一个`Observable`而不是`Stream`。
  /// 此Subject允许向侦听器发送数据，错误和完成事件。
  /// 默认情况下，PublishSubject是广播（又称热门）控制器，以便履行Rx主题合同。 这意味着可以多次收听主题的“流”。
  final PublishSubject<Event> _eventSubject = PublishSubject<Event>();

  BehaviorSubject<State> _stateSubject;

  /// Returns [Stream] of [Event]s.
  /// When an [Event] is dispatched, it is added to the [Stream].
  /// 返回Event流(stream)
  /// 当Event被触发[dispatched]时，会将其添加到[Stream]
  Stream<Event> get event => _eventSubject.stream;

  /// Returns [Stream] of [State]s.
  /// Usually consumed by the presentation layer.
  /// 返回state流(stream) 由UI层使用。
  Stream<State> get state => _stateSubject.stream;

  /// Returns the [State] before any [Event]s have been `dispatched`.
  State get initialState;

  /// Returns the current [State] of the [Bloc].
  /// 在所有event被分发(dispatched)之前 返回 State ==> 即状态的初始值，在编码时一定要赋初始值
  State get currentState => _stateSubject.value;

  Bloc() {
    /// 通过初始状态进行初始化
    _stateSubject = BehaviorSubject<State>.seeded(initialState);

    /// 状态绑定
    _bindStateSubject();
  }

  /// Called whenever an [Event] is dispatched to the [Bloc].
  /// A great spot to add logging/analytics at the individual [Bloc] level.
  ///
  /// 每当[事件]被分派到[Bloc]时调用。
  /// 在个人[Bloc]级别添加日志记录/分析的好地方
  void onEvent(Event event) => null;

  /// Called whenever a [Transition] occurs with the given [Transition].
  /// A [Transition] occurs when a new [Event] is dispatched and `mapEventToState` executed.
  /// `onTransition` is called before a [Bloc]'s [State] has been updated.
  /// A great spot to add logging/analytics at the individual [Bloc] level.
  ///
  /// 在任何[Bloc]中使用给定[Transition]发生转换时被调用。
  /// 当 新的[Event]被分发(dispatched)并且执行`mapEventToState`时 发生 转换 [Transition]。
  /// onTransition 在[Bloc]的状态更新之前被调用。
  /// 添加通用日志记录/分析的好地方。(不过也得在子类)
  /// 理解：-- 这个是针对某个类，如果用代理的话则是针对所有
  void onTransition(Transition<Event, State> transition) => null;

  /// Called whenever an [Exception] is thrown within `mapEventToState`.
  /// By default all exceptions will be ignored and [Bloc] functionality will be unaffected.
  /// The stacktrace argument may be `null` if the state stream received an error without a [StackTrace].
  /// A great spot to handle exceptions at the individual [Bloc] level.、
  ///
  /// 在`mapEventToState`中抛出[Exception]时调用。
  /// 默认情况下，所有异常都将被忽略，[Bloc]功能不受影响。
  /// 如果状态流在没有[StackTrace]的情况下收到错误，则stacktrace参数可能为“null”。
  /// 在个人[Bloc]级别处理异常的好地方。
  ///
  void onError(Object error, StackTrace stacktrace) => null;

  /// Takes an [Event] and triggers `mapEventToState`.
  /// `Dispatch` may be called from the presentation layer or from within the [Bloc].
  /// `Dispatch` notifies the [Bloc] of a new [Event].
  /// If `dispose` has already been called, any subsequent calls to `dispatch` will
  /// be delegated to the `onError` method which can be overriden at the [Bloc]
  /// as well as the [BlocDelegate] level.
  ///
  /// 获取Event并触发mapEventToState。
  /// Dispatch可以 在UI层 或 在bloc内部被调用。
  /// Dispatch通知bloc 新的 Event。
  /// 如果dispose已经被调用，则任何后续 的dispatch 调用都将被委托给 onError，
  /// onError可以在 Bloc 以及BlocDelegate级别覆盖的方法。
  ///
  void dispatch(Event event) {
    try {
      BlocSupervisor.delegate.onEvent(this, event);
      onEvent(event);
      _eventSubject.sink.add(event);
    } catch (error) {
      _handleError(error);
    }
  }

  /// Closes the [Event] and [State] [Stream]s.
  /// This method should be called when a [Bloc] is no longer needed.
  /// Once `dispose` is called, events that are `dispatched` will not be
  /// processed and will result in an error being passed to `onError`.
  /// In addition, if `dispose` is called while [Event]s are still being processed,
  /// any [State]s yielded after are ignored and will not result in a [Transition].
  ///
  /// 关闭[Event]和[State] [Stream] s。
  /// 当不再需要[Bloc]时，应该调用此方法。
  /// 一旦`dispose`被调用，`dispatched`的事件将不会被处理，并将导致错误传递给`onError`。
  /// 此外，如果在[Event] s仍在处理时调用`dispose`，
  /// 被忽略的任何[State] s被忽略，不会导致[Transition]。
  ///
  /// mustCallSuper该注解表示一定要调用super.dispose();
  @mustCallSuper
  void dispose() {
    _eventSubject.close();
    _stateSubject.close();
  }

  /// Transforms the `Stream<Event>` along with a `next` function into a `Stream<State>`.
  /// 将`Stream <Event>`和`next`函数转换为`Stream <State>`。
  ///
  /// Events that should be processed by `mapEventToState` need to be passed to `next`.
  /// 应该由`mapEventToState`处理的事件需要传递给`next`。
  ///
  /// By default `asyncExpand` is used to ensure all events are processed in the order
  /// in which they are received. You can override `transform` for advanced usage
  /// in order to manipulate the frequency and specificity with which `mapEventToState`
  /// is called as well as which events are processed.
  /// 默认情况下，`asyncExpand`用于确保按接收顺序处理所有事件。
  /// 您可以重写`transform`以进行高级用法，以便操纵调用`mapEventToState`的频率和特异性以及处理哪些事件。
  ///
  /// For example, if you only want `mapEventToState` to be called on the most recent
  /// event you can use `switchMap` instead of `asyncExpand`.
  ///
  /// ```dart
  /// @override
  /// Stream<State> transform(events, next) {
  ///   return (events as Observable<Event>).switchMap(next);
  /// }
  /// ```
  ///
  /// Alternatively, if you only want `mapEventToState` to be called for distinct events:
  ///
  /// ```dart
  /// @override
  /// Stream<State> transform(events, next) {
  ///   return super.transform(
  ///     (events as Observable<Event>).distinct(),
  ///     next,
  ///   );
  /// }
  /// ```
  Stream<State> transform(
    Stream<Event> events,
    Stream<State> next(Event event),
  ) {
    return events.asyncExpand(next);
  }

  /// Must be implemented when a class extends [Bloc].
  /// Takes the incoming `event` as the argument.
  /// `mapEventToState` is called whenever an [Event] is `dispatched` by the presentation layer.
  /// `mapEventToState` must convert that [Event] into a new [State]
  /// and return the new [State] in the form of a [Stream] which is consumed by the presentation layer.
  Stream<State> mapEventToState(Event event);

  void _bindStateSubject() {
    Event currentEvent;

    transform(_eventSubject, (Event event) {
      currentEvent = event;
      return mapEventToState(currentEvent).handleError(_handleError);
    }).forEach(
      (State nextState) {
        if (currentState == nextState || _stateSubject.isClosed) return;
        final transition = Transition(
          currentState: currentState,
          event: currentEvent,
          nextState: nextState,
        );
        BlocSupervisor.delegate.onTransition(this, transition);
        onTransition(transition);
        _stateSubject.add(nextState);
      },
    );
  }

  void _handleError(Object error, [StackTrace stacktrace]) {
    BlocSupervisor.delegate.onError(this, error, stacktrace);
    onError(error, stacktrace);
  }
}
