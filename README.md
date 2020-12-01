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
  int count = 0;

  @action
  void increaseCount() {
    count++;
  }
}
```

2. Create your first system by extends `StoreReactiveSystem`

```
class CounterSystem extends StoreReactiveSystem<AppStore, int> {
  final StoresContext context;

  CounterSystem(this.context) : super(context);

  // 1. Get the variable we want to react to changes inside the AppStore
  @override
  int trigger(AppStore store) {
    return store.count;
  }

  // 2. Filter out if we don't want to react in the execute()
  @override
  bool filter(int count) {
    return count > 0;
  }

  // 3. Do something after count value changed.
  @override
  void execute(int count) {
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

- **StoreReactiveSystem<TStore, TValue>** - React to value changes inside the store.
- **EventReactiveSystem<TStore>** - React to `ObservableEvent` trigger inside the store.
- **EventValueReactiveSystem<TStore, TValue>** - Same as `EventReactiveSystem` but with value.
- **SetupSystem** - Execute at the begining of the app.
- **StartSystem** - Execute after setup.
- **TeardownSystem** - Execute at the end of the app life time.
- **Systems** - Compose of multiple system. You can nested `Systems` inside a `Systems`.
