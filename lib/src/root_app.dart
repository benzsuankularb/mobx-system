import 'package:flutter/material.dart';
import 'package:mobx_system/mobx_system.dart';
import 'package:provider/provider.dart';

typedef System SystemBuilder();
typedef Widget WidgetBuilder();
typedef Map<String, dynamic> ArgsBuilder();

abstract class CorssDependenciesInjector {
  injectDependencies(void Function<T>(T value) inject);
}

class RootApp extends StatefulWidget {
  final ArgsBuilder args;
  final SystemBuilder system;
  final WidgetBuilder app;
  final CorssDependenciesInjector injector;

  const RootApp({
    @required this.app,
    @required this.system,
    @required this.injector,
    this.args,
  });

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  Dependencies dependencies = Dependencies();
  List<Provider> providers = [];
  SystemContext systemContext;

  @override
  void initState() {
    super.initState();
    createCrossDependencies();
    systemContext = SystemContext(
      widget.system(),
      dependencies: dependencies,
      args: widget.args?.call() ?? {},
    );
    systemContext.start();
  }

  void createCrossDependencies() {
    final inject = <T>(T value) {
      addCrossDependency<T>(value);
    };
    widget.injector.injectDependencies(inject);
  }

  void addCrossDependency<T>(T service) {
    var provider = Provider<T>(
      create: (_) => service,
    );
    providers.add(provider);
    dependencies.add<T>(service);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: widget.app(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    systemContext.dispose();
  }
}
