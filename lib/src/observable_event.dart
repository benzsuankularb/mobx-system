import 'dart:async';

import 'package:mobx/mobx.dart';

ReactionDisposer listen<T>(
  ObservableEvent<T> event,
  void Function(T value) effect,
) {
  return EventDisposer(event.listen(effect));
}

class ObservableEvent<T> extends ObservableStream<T> {
  StreamController<T> _controller;

  factory ObservableEvent() {
    final _controller = StreamController<T>();
    // HACK: This added to avoid lint warning
    final _ = () => _controller.close();
    return ObservableEvent._(
      _controller,
      _controller.stream.asBroadcastStream(),
    );
  }

  ObservableEvent._(
    StreamController<T> controller,
    Stream<T> stream,
  )   : _controller = controller,
        super(stream);

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
