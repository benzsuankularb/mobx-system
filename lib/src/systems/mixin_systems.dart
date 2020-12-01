import 'package:meta/meta.dart';
import 'package:mobx_system/src/systems/disposers/disposer.dart';

abstract class System {}

abstract class SetupSystem implements System {
  Future<void> setup();
}

abstract class StartSystem implements System {
  Future<void> start();
}

abstract class TeardownSystem implements System {
  Future<void> teardown();
}

abstract class ReactiveSystem implements System {
  Disposer _disposer;

  @mustCallSuper
  void activateReactive() {
    _disposer = createReactive();
  }

  @mustCallSuper
  void deactivateReactive() {
    _disposer.dispose();
    _disposer = null;
  }

  @protected
  Disposer createReactive();
}
