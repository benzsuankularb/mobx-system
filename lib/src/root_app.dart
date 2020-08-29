import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobx_system/src/system/system.dart';

typedef System SystemBuilder();
typedef Widget WidgetBuilder();

abstract class CorssDependenciesInjector {
  injectDependencies(void Function<T>(T value) inject);
}

class RootApp extends StatefulWidget {
  final SystemBuilder system;
  final WidgetBuilder app;
  final CorssDependenciesInjector injector;

  const RootApp({
    @required this.app,
    @required this.system,
    @required this.injector,
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
    );
    systemContext.start();
  }

  void createCrossDependencies() {
    void inject<T>(T value) {
      if (value is CorssDependenciesInjector) {
        value.injectDependencies(inject);
      } else {
        addCrossDependency<T>(value);
      }
    }

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
