import 'package:mobx/mobx.dart';
import 'package:mobx_system/src/stores_context.dart';
import 'package:mobx_system/src/observable_event.dart';
import 'package:mobx_system/src/systems/disposers/disposer.dart';
import 'package:mobx_system/src/systems/disposers/event_reactive_disposer.dart';
import 'package:mobx_system/src/systems/mixin_systems.dart';

abstract class EventReactiveSystem<TStore extends Store> with ReactiveSystem {
  final StoresContext context;

  EventReactiveSystem(this.context);

  @override
  Disposer createReactive() {
    final store = context.get<TStore>();
    // ignore: cancel_subscriptions
    final subscription = getTrigger(store).listen((_) => execute());
    return EventReactiveDisposer(subscription);
  }

  ObservableEvent getTrigger(TStore store);

  void execute();
}

abstract class EventValueReactiveSystem<TStore extends Store, TValue>
    with ReactiveSystem, System {
  final StoresContext contexts;

  EventValueReactiveSystem(this.contexts);

  @override
  Disposer createReactive() {
    final store = contexts.get<TStore>();
    // ignore: cancel_subscriptions
    final subscription = getTrigger(store).listen((TValue value) {
      if (filter(value)) {
        execute(value);
      }
    });
    return EventReactiveDisposer(subscription);
  }

  ObservableEvent<TValue> getTrigger(TStore store);

  bool filter(TValue value) => true;

  void execute(TValue value);
}
