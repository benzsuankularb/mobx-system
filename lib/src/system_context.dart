part of 'system.dart';

class SystemContext {
  final Map<String, dynamic> args;
  final System system;
  final Dependencies dependencies;

  SystemContext(
    this.system, {
    this.args = const {},
    Dependencies dependencies,
  })  : assert(system != null),
        assert(args != null),
        dependencies = dependencies ?? Dependencies();

  void start() async {
    system._setContext(this);
    await system._createDependencies(dependencies);
    await system._loadDependencies(dependencies);
    await system._setUp();
    await system._start();
  }

  void dispose() async {
    await system._dispose();
  }
}
