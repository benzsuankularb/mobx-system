import 'package:mobx_system/src/stores_context.dart';
import 'package:test/test.dart';
import 'dummy_store/dummy_store.dart';

void main() {
  test('get non exist store', () {
    final contexts = StoresContext([]);
    expect(
      () => contexts.get<DummyStore>(),
      throwsA(isA<AssertionError>()),
    );
  });

  test('get store', () {
    final dummyStore = DummyStore();
    final contexts = StoresContext([dummyStore]);
    expect(contexts.get<DummyStore>(), equals(dummyStore));
  });
}
