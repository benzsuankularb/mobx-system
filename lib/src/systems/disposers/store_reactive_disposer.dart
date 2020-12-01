import 'package:mobx/mobx.dart';
import 'package:mobx_system/src/systems/disposers/disposer.dart';

class StoreReactionDisposer implements Disposer {
  ReactionDisposer disposer;

  StoreReactionDisposer(this.disposer);

  @override
  void dispose() {
    disposer.reaction.dispose();
  }
}
