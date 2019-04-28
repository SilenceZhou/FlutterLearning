import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocEvent extends Object {}

abstract class BlocState extends Object {}

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  /// 利用了RxDart来
  /// PublishSubject:普通的广播StreamController,仅向监听器发送在订阅之后添加到Stream的事件
  /// 完全像普通的广播StreamController有一个例外：`stream`返回一个`Observable`而不是`Stream`。
  /// 此Subject允许向侦听器发送数据，错误和完成事件。
  /// 默认情况下，PublishSubject是广播（又称热门）控制器，以便履行Rx主题合同。 这意味着可以多次收听主题的“流”。
  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();

  /// BehaviorSubject:与PublishSubject的主要区别在于BehaviorSubject还将最后发送的事件发送给刚刚订阅的监听器。
  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  ///
  /// To be invoked to emit an event
  ///
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  ///
  /// Current/New state
  ///
  Stream<BlocState> get state => _stateController.stream;

  ///
  /// Last State
  ///
  BlocState get lastState => _stateController.value;

  ///
  /// External processing of the event
  /// 事件的外部处理
  ///
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  ///
  /// initialState
  ///
  final BlocState initialState;

  //
  // Constructor
  //
  BlocEventStateBase({
    @required this.initialState,
  }) {
    //
    // 对于每个接收到的事件，我们调用[eventHandler]并发出任何结果的newState
    //
    _eventController.listen((BlocEvent event) {
      BlocState currentState = lastState ?? initialState;
      eventHandler(event, currentState).forEach((BlocState newState) {
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
