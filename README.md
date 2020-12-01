Language: [English](README.md) | [Português](translation/pt-BR/README.md) | [Chinese](translation/zh-CN/README.md)

# mobx_system

> Solid reactive style state-management build on mobx.dart

- **[Get Started](#get-started)**
- **[Core Systems](#core-systems)**

## Get Started

1. Crate a store and generate using `mobx_codegen`, See `mobx.dart` for more example.

```your_store.dart
class YourStore = _YourStoreBase with _$YourStore;

abstract class _YourStoreBase with Store {
  @observable
  ObservableEvent onCount = ObservableEvent();

  @observable
  int counter = 0;

  @observable
  int multiplyCounter = 0;

  @action
  void increaseCount() {
    counter++;
  }
}
```

2. Create your first system by extends `StoreReactiveSystem`

```
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
```

3. `MobxSystemApp` at top most widget then add `YourSystem` and `YourStore` to your `MobxSystemApp`

You can add multiple systems and stores as you want.

```main.dart
import 'package:mobx_system/mobx_system.dart';

main() {
    runApp(YourApp());
}

class YourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobxSystemApp(
      systemBuilder: (context) => [
        CounterSystem(context),
        CounterEventSystem(context),
      ],
      stores: [
        AppStore(),
      ],
      child: MaterialApp(
        ...
      ),
    );
  }
}
```

4. Run the app.

## Core Systems
