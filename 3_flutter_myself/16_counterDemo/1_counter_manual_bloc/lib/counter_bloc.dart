import 'dart:async';

import './counter_event.dart';

class CounterBloc {
  int _counter = 0;

  /// state
  final _counterStateController = StreamController<int>();
  // sink  : input
  StreamSink<int> get _inCounterSink => _counterStateController.sink;
  // stream : ountput 
  Stream<int> get counter => _counterStateController.stream;


  // event
  final _counterEventController =StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc(){

    // _mapEventToStatew为监听者
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncreamentEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _inCounterSink.add(_counter);
  }

  dispose(){
    _counterStateController.close();
    _counterEventController.close();
  }

}
