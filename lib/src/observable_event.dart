import 'dart:async';

import 'package:mobx/mobx.dart';

@deprecated
ReactionDisposer listen<T>(
  ObservableEvent<T> event,
  void Function(T value) effect,
) {
  return EventDisposer(event.listen(effect));
}

class ObservableEvent<T> extends ObservableStream<T> {
  StreamController<T> _controller;
  Stream<T> get stream => _controller.stream;
  StreamSink<T> get sink => _controller.sink;

  factory ObservableEvent() {
    return ObservableEvent._(StreamController<T>.broadcast());
  }

  ObservableEvent._(
    StreamController<T> controller,
  )   : _controller = controller,
        super(controller.stream);

  void call([T value]) {
    return _controller.sink.add(value);
  }

  void dispose() {
    _controller.close();
  }
}

class EventDisposer implements ReactionDisposer {
  final StreamSubscription subscription;

  const EventDisposer(this.subscription);

  void call() {
    subscription.cancel();
  }

  @override
  Reaction get reaction => null;
}
