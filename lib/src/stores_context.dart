import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class StoresContextScope extends InheritedWidget {
  final StoresContext context;

  StoresContextScope({
    @required this.context,
    @required Widget child,
    Key key,
  })  : assert(context != null),
        assert(child != null),
        super(
          child: child,
          key: key,
        );

  @override
  bool updateShouldNotify(covariant StoresContextScope oldWidget) {
    return oldWidget.context == context;
  }
}

class StoresContext {
  Map<String, Store> _stores;

  StoresContext(List<Store> stores) : assert(stores != null) {
    _stores = {
      for (var store in stores) store.runtimeType.toString(): store,
    };
  }

  T get<T extends Store>() {
    assert(
      _stores.containsKey(T.toString()),
      "Store type $T is not exist in the contexts.",
    );
    return _stores[T.toString()] as T;
  }

  static StoresContext of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StoresContextScope>()
        .context;
  }
}
