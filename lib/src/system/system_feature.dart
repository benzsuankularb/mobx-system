part of 'system.dart';

class AggregateSystem extends Feature {
  final List<System> systems;

  AggregateSystem(this.systems);

  @override
  List<System> createSystems() {
    return systems;
  }
}

abstract class Feature extends System {
  List<System> systems;

  Feature() {
    systems = createSystems() ?? [];
  }

  List<System> createSystems();

  @override
  void _setContext(SystemContext context) {
    super._setContext(context);
    systems.forEach((system) => system._setContext(context));
  }

  @override
  _createDependencies() async {
    await super._createDependencies();
    if (filterCreateDependencies()) {
      for (var system in systems) {
        await system._createDependencies();
      }
    }
  }

  @override
  _loadDependencies() async {
    await super._loadDependencies();
    if (filter()) {
      for (var system in systems) {
        await system._loadDependencies();
      }
    }
  }

  @override
  _setUp() async {
    await super._setUp();
    if (filter()) {
      for (var system in systems) {
        await system._setUp();
      }
    }
  }

  @override
  void _start() async {
    await super._start();
    if (filter()) {
      for (var system in systems) {
        await system._start();
      }
    }
  }

  @override
  void _dispose() async {
    await super._dispose();
    if (filter()) {
      for (var system in systems) {
        await system._dispose();
      }
    }
  }
}
