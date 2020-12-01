import 'package:mobx/mobx.dart';
import 'package:mobx_system/mobx_system.dart';
part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  @observable
  ObservableEvent onCount = ObservableEvent();

  @observable
  int counter = 0;

  @observable
  int multiplyCounter = 0;

  @action
  void increaseCount() {
    counter++;
  }
}
