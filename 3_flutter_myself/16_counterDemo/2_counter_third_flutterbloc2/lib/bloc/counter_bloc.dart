import 'dart:async';
import 'package:bloc/bloc.dart';
// import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  // CounterState get initialState => InitialCounterState();
  // 由于我们的计数器状态可以用整数表示，因此我们不需要创建自定义类！
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {

    switch (event) {
      // currentState 不能做自加自减
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      default:
    }
  }
}
