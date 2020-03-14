part of 'system.dart';

class MultiSystems extends Feature {
  final List<System> systems;

  MultiSystems(this.systems);

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
  _createDependencies(Dependencies dependencies) async {
    await super._createDependencies(dependencies);
    if (filter(_context.args)) {
      for (var system in systems) {
        await system._createDependencies(dependencies);
      }
    }
  }

  @override
  _loadDependencies(Dependencies dependencies) async {
    await super._loadDependencies(dependencies);
    if (filter(_context.args)) {
      for (var system in systems) {
        await system._loadDependencies(dependencies);
      }
    }
  }

  @override
  _setUp() async {
    await super._setUp();
    if (filter(_context.args)) {
      for (var system in systems) {
        await system._setUp();
      }
    }
  }

  @override
  void _start() async {
    await super._start();
    if (filter(_context.args)) {
      for (var system in systems) {
        await system._start();
      }
    }
  }

  @override
  void _dispose() async {
    await super._dispose();
    if (filter(_context.args)) {
      for (var system in systems) {
        await system._dispose();
      }
    }
  }
}
