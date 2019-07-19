import 'dart:async';
import '../framework/dart_bloc/bloc.dart';
import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
    }
  }

  @override
  Stream<int> transform(
    Stream<CounterEvent> events,
    Stream<int> Function(CounterEvent event) next,
  ) {
    print('CounterBloc : \n events = $events \n next = $next');

    return super.transform(events, next);
  }
}
