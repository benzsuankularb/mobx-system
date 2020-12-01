import 'package:mobx/mobx.dart';
import 'package:mobx_system/src/stores_context.dart';
import 'package:mobx_system/src/systems/disposers/disposer.dart';
import 'package:mobx_system/src/systems/disposers/store_reactive_disposer.dart';
import 'package:mobx_system/src/systems/mixin_systems.dart';

abstract class StoreReactiveSystem<TStore extends Store, TValue>
    with ReactiveSystem {
  StoresContext context;

  StoreReactiveSystem(this.context);

  @override
  Disposer createReactive() {
    var store = context.get<TStore>();
    final disposer = reaction<TValue>((_) => trigger(store), (TValue value) {
      if (filter(value)) {
        execute(value);
      }
    });
    return StoreReactionDisposer(disposer);
  }

  TValue trigger(TStore store);

  bool filter(TValue value) => true;

  void execute(TValue value);
}
