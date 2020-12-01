import 'dart:async';

import 'package:mobx_system/src/systems/disposers/disposer.dart';

class EventReactiveDisposer implements Disposer {
  StreamSubscription subscription;

  EventReactiveDisposer(this.subscription);

  @override
  void dispose() {
    subscription.cancel();
  }
}
