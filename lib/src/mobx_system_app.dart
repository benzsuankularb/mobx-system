import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_system/src/stores_context.dart';
import 'package:mobx_system/src/systems/mixin_systems.dart';
import 'package:mobx_system/src/systems/systems.dart';

typedef List<System> SystemsBuilder(StoresContext context);

class MobxSystemApp extends StatefulWidget {
  final SystemsBuilder systemBuilder;
  final List<Store> stores;
  final Widget child;

  const MobxSystemApp({
    @required this.child,
    @required this.systemBuilder,
    @required this.stores,
  })  : assert(child != null),
        assert(systemBuilder != null),
        assert(stores != null);

  @override
  _MobxSystemAppState createState() => _MobxSystemAppState();
}

class _MobxSystemAppState extends State<MobxSystemApp> {
  Systems systems;
  StoresContext storeContext;

  @override
  void initState() {
    super.initState();
    storeContext = StoresContext(widget.stores);
    systems = Systems(
      storeContext,
      systems: widget.systemBuilder(storeContext),
    );
    () async {
      await systems.setup();
      await systems.start();
      systems.activateReactive();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return StoresContextScope(
      context: storeContext,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    systems.teardown();
    systems.deactivateReactive();
  }
}
