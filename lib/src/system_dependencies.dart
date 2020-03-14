part of 'system.dart';

class Dependencies {
  static _getNoDependencyMessage(Type type, {String key}) {
    return key == null
        ? "No dependency of type `${type.toString()}` was found."
        : "No dependency of type `${type.toString()}` with key $key was found.";
  }

  final GetIt _getIt;

  Dependencies() : _getIt = GetIt.asNewInstance() {
    _getIt.allowReassignment = true;
  }

  T get<T>({String key}) {
    var value = _getIt.get<T>(key);
    assert(
      value != null,
      _getNoDependencyMessage(T.runtimeType, key: key),
    );
    return value;
  }

  void add<T>(T value, {String instanceName}) {
    assert(value != null);
    _getIt.registerSingleton(value, instanceName: instanceName);
  }

  void addLazy<T>(T Function() builder, {String instanceName}) {
    assert(builder != null);
    _getIt.registerLazySingleton(builder, instanceName: instanceName);
  }
}
