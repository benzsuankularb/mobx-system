import 'package:mobx_system/src/stores_context.dart';
import 'package:mobx_system/src/systems/disposers/disposer.dart';
import 'package:mobx_system/src/systems/mixin_systems.dart';
import 'package:mobx_system/src/systems/systems.dart';
import 'package:test/test.dart';

void main() {
  StoresContext contexts;
  MockSystem mockSystem;
  Systems mainSystem;

  setUpAll(() {
    contexts = StoresContext([]);
    mockSystem = MockSystem(contexts);
    mainSystem = Systems(contexts, systems: [mockSystem]);
  });

  test('setup', () {
    mainSystem.setup();
    expect(mockSystem.setupCount, equals(1));
  });

  test('teardown', () {
    mainSystem.teardown();
    expect(mockSystem.teardownCount, equals(1));
  });

  test('start', () {
    mainSystem.start();
    expect(mockSystem.startCount, equals(1));
  });

  test('activateReactive', () {
    mainSystem.activateReactive();
    expect(mockSystem.activateReactiveCount, equals(1));
  });

  test('deactivateReactive', () {
    mainSystem.activateReactive();
    mainSystem.deactivateReactive();
    expect(
      mockSystem.deactivateReactiveCount,
      equals(1),
    );
  });

  tearDownAll(() {
    contexts = null;
    mockSystem = null;
    mainSystem = null;
  });
}

// class MockDisposer extends Disposer {
//   int disposeCount = 0;
//   @override
//   void dispose() {
//     disposeCount++;
//   }
// }

class MockSystem
    implements ReactiveSystem, SetupSystem, StartSystem, TeardownSystem {
  MockSystem(StoresContext contexts);

  int setupCount = 0;
  int startCount = 0;
  int teardownCount = 0;
  int activateReactiveCount = 0;
  int deactivateReactiveCount = 0;

  @override
  Disposer createReactive() => null;

  @override
  void activateReactive() {
    activateReactiveCount++;
  }

  @override
  void deactivateReactive() {
    deactivateReactiveCount++;
  }

  @override
  Future<void> setup() async {
    setupCount++;
  }

  @override
  Future<void> start() async {
    startCount++;
  }

  @override
  Future<void> teardown() async {
    teardownCount++;
  }
}
