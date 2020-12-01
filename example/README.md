Language: [English](README.md) | [Português](translation/pt-BR/README.md) | [Chinese](translation/zh-CN/README.md)

# mobx_system

> Solid reactive style state-management build on mobx.dart

- **[Installation](#installation)**
- **[Examples](#examples)**

## Installation

## Examples

1. Crate `MobxSystemApp` at top most widget.

```
import 'package:mobx_system/mobx_system.dart';

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

1. Crate `MobxSystemApp` at top most widget.
