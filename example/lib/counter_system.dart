import 'package:example/app_store.dart';
import 'package:mobx_system/mobx_system.dart';

class CounterSystem extends StoreReactiveSystem<AppStore, int> {
  final StoresContext context;

  CounterSystem(this.context) : super(context);

  @override
  int trigger(AppStore store) {
    return store.counter;
  }

  @override
  void execute(int counter) {
    final appStore = context.get<AppStore>();
    appStore.multiplyCounter += counter * 2;
  }
}
