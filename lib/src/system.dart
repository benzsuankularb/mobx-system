import 'package:get_it/get_it.dart';

part 'system_feature.dart';
part 'system_dependencies.dart';
part 'system_context.dart';

abstract class System {
  SystemContext _context;

  void _setContext(SystemContext context) {
    _context = context;
  }

  _createDependencies(Dependencies dependencies) async {
    if (filter(_context.args)) {
      await createDependencies(dependencies);
    }
  }

  _loadDependencies(Dependencies dependencies) async {
    if (filter(_context.args)) {
      await loadDependencies(dependencies);
    }
  }

  _setUp() async {
    if (filter(_context.args)) {
      await setUp();
    }
  }

  _start() async {
    if (filter(_context.args)) {
      await start();
    }
  }

  _dispose() async {
    if (filter(_context.args)) {
      await dispose();
    }
  }

  bool filter(Map<String, dynamic> args) => true;
  createDependencies(Dependencies dependencies) {}
  loadDependencies(Dependencies dependencies) {}
  setUp() {}
  start() {}
  dispose() {}
}
