import 'package:mobx/mobx.dart';
part 'dummy_store.g.dart';

class DummyStore = _DummyStoreBase with _$DummyStore;

abstract class _DummyStoreBase with Store {}
