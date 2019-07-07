import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// 需要Event流(stream)的作为输入，并将其变换成State流(Stream)作为输出。
abstract class Bloc<Event, State> {
/// 利用了RxDart来
  /// PublishSubject:普通的广播StreamController,仅向监听器发送在订阅之后添加到Stream的事件
  /// 完全像普通的广播StreamController有一个例外：`stream`返回一个`Observable`而不是`Stream`。
  /// 此Subject允许向侦听器发送数据，错误和完成事件。
  /// 默认情况下，PublishSubject是广播（又称热门）控制器，以便履行Rx主题合同。 这意味着可以多次收听主题的“流”。
  final PublishSubject<Event> _eventSubject = PublishSubject<Event>();
  BehaviorSubject<State> _stateSubject;

  /// 返回state流(stream) 由UI层使用。
  Stream<State> get state => _stateSubject.stream;

  /// 在所有event被分发(dispatched)之前 返回 State ==> 即状态的初始值，在编码时一定要赋初始值
  State get initialState;

  /// BLoC 当前的 state
  State get currentState => _stateSubject.value;

  ///构造方法
  Bloc() {
    /// 获取初始状态
    _stateSubject = BehaviorSubject<State>.seeded(initialState);
    /// 状态绑定
    _bindStateSubject();
  }

  /// 在任何[Bloc]中使用给定[Transition]发生转换时被调用。
  /// 当 新的[Event]被分发(dispatched)并且执行`mapEventToState`时 发生 转换 [Transition]。
  /// `onTransition`在[Bloc]的状态更新之前被调用。
  /// 添加通用日志记录/分析的好地方。(不过也得在子类) -- 这个是针对某个类，如果用代理的话则是针对所有
  void onTransition(Transition<Event, State> transition) => null;

  /// 无论何时在任何一个bloc中的mapEventToState 抛出 Exception，onError都会被调用。
  /// 如果状态流在没有[StackTrace]的情况下收到错误，则stacktrace参数可以是“null”。
  /// 添加通用错误处理的好地方。
  void onError(Object error, StackTrace stacktrace) => null;

  /// 获取Event并触发mapEventToState。 Dispatch可以 在UI层 或 在bloc内部被调用。  Dispatch通知bloc 新的 Event。
  /// 如果dispose已经被调用，则任何后续 的dispatch 调用都将被委托给 onError，
  /// onError可以在 Bloc 以及BlocDelegate级别覆盖的方法。
  void dispatch(Event event) {
    try {
      _eventSubject.sink.add(event);
    } catch (error) {
      _handleError(error);
    }
  }

  /// 关闭 event 和 state 的流, 供外部调用
  /// mustCallSuper该注解表示一定要调用super.dispose();
  @mustCallSuper
  void dispose() {
    _eventSubject.close();
    _stateSubject.close();
  }
  
  /// Stream<Event> 的转换(Transform) 在mapEventToState之前 调用。
  /// 这允许像操作distinct()，debounce()等...得到应用。
  /// 
  Stream<Event> transform(Stream<Event> events) => events;

  /// 当一个类继承Bloc时，必须实现 mapEventToState 方法.
  ///  该函数将传入事件作为参数。
  /// 只要UI层触发一个事件，就会调用 mapEventToState。
  /// mapEventToState 必须将该event转换为新state，并以UI层使用的Stream形式返回新状态。
  /// 
  Stream<State> mapEventToState(Event event);



  void _bindStateSubject() {
    Event currentEvent;
    /* asyncExpand
    将每个元素转换为一系列异步事件。
    返回一个新流，并为该流的每个事件执行以下操作：
    如果事件是错误事件或完成事件，则由返回的流直接发出。
    否则它是一个元素。 然后使用元素作为参数调用[convert]函数，以生成元素的转换流。

    如果该调用抛出，则在返回的流上发出错误。

    如果调用返回null，则不对元素采取进一步操作。

    否则，暂停此流并收听转换流。 转换流的每个数据和错误事件都按照生成的顺序在返回的流上发出。 当转换流结束时，恢复该流。

    如果此流是，则返回的流是广播流。
    */
    transform(_eventSubject).asyncExpand((Event event) {
      currentEvent = event;
      return mapEventToState(currentEvent).handleError(_handleError);
    }).forEach( (State nextState) {
        if (currentState == nextState) return;
        final transition = Transition(
          currentState: currentState,
          event: currentEvent,
          nextState: nextState,
        );
        /// 截取方法
        BlocSupervisor().delegate?.onTransition(transition);

        // 最终调用
        onTransition(transition);
        /*
         add:
         发送数据[事件]。

        监听器在稍后的微任务中收到此事件(event)。

        请注意，同步控制器（通过将true传递给StreamController构造函数的sync参数创建）会立即传递事件。 
        由于此行为违反了此处提到的合同，因此只应按照文档中的说明使用同步控制器，以确保传递的事件始终显示为在单独的微任务中传递它们。

        从StreamController复制。
        */
        _stateSubject.add(nextState);
      },
    );
  }

  void _handleError(Object error, [StackTrace stacktrace]) {
    onError(error, stacktrace);
    BlocSupervisor().delegate?.onError(error, stacktrace);
  }
}
