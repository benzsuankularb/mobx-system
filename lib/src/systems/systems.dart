import 'package:mobx_system/src/stores_context.dart';
import 'package:mobx_system/src/systems/disposers/disposer.dart';
import 'package:mobx_system/src/systems/mixin_systems.dart';

class Systems
    implements ReactiveSystem, SetupSystem, StartSystem, TeardownSystem {
  final StoresContext context;
  final List<System> systems;

  Systems(
    this.context, {
    this.systems = const <System>[],
  })  : assert(context != null),
        assert(systems != null);

  void add(System system) {
    systems.add(system);
  }

  @override
  Future<void> setup() async {
    for (final system in systems) {
      if (system is SetupSystem) {
        await system.setup();
      }
    }
  }

  @override
  Future<void> start() async {
    for (final system in systems) {
      if (system is StartSystem) {
        await system.start();
      }
    }
  }

  @override
  Future<void> teardown() async {
    for (final system in systems) {
      if (system is TeardownSystem) {
        await system.teardown();
      }
    }
  }

  @override
  void activateReactive() {
    for (final system in systems) {
      if (system is ReactiveSystem) {
        system.activateReactive();
      }
    }
  }

  @override
  void deactivateReactive() {
    for (final system in systems) {
      if (system is ReactiveSystem) {
        system.deactivateReactive();
      }
    }
  }

  @override
  Disposer createReactive() => null;
}
