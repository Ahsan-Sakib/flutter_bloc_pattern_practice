import 'dart:async';

import 'package:practice_bloc_pattern/counter_event.dart';

class CounterBloc {
  int _counter = 0;
  final _counterStateController = StreamController<int>();

  StreamSink<int> get _intCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  final counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEvent => counterEventController.sink;

  CounterBloc() {
    counterEventController.stream.listen(_mapEvent);
  }

  _mapEvent(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _intCounter.add(_counter);
  }

  dispose() {
    _counterStateController.close();
    counterEventController.close();
  }
}
