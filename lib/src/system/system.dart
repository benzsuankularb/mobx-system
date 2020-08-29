import 'package:get_it/get_it.dart';

part 'system_feature.dart';
part 'system_dependencies.dart';
part 'system_context.dart';

abstract class System {
  SystemContext _context;
  Dependencies get dependencies => _context.dependencies;

  void _setContext(SystemContext context) {
    _context = context;
  }

  _createDependencies() async {
    if (filterCreateDependencies()) {
      await createDependencies();
    }
  }

  _loadDependencies() async {
    if (filter()) {
      await loadDependencies();
    }
  }

  _setUp() async {
    if (filter()) {
      await setUp();
    }
  }

  _start() async {
    if (filter()) {
      await start();
    }
  }

  _dispose() async {
    if (filter()) {
      await dispose();
    }
  }

  bool filterCreateDependencies() => true;
  bool filter() => true;
  createDependencies() {}
  loadDependencies() {}
  setUp() {}
  start() {}
  dispose() {}
}
