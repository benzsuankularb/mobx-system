import 'package:example/app_store.dart';
import 'package:mobx_system/mobx_system.dart';

class CounterEventSystem extends EventReactiveSystem<AppStore> {
  final StoresContext context;

  CounterEventSystem(this.context) : super(context);

  @override
  ObservableEvent getTrigger(AppStore store) {
    return store.onCount;
  }

  @override
  void execute() {
    final appStore = context.get<AppStore>();
    appStore.increaseCount();
  }
}
