import 'package:mobx_system/src/systems/disposers/disposer.dart';

class CompositeDisposer implements Disposer {
  List<Disposer> disposers;

  CompositeDisposer(this.disposers);

  @override
  void dispose() {
    for (var disposer in disposers) {
      disposer.dispose();
    }
  }
}
