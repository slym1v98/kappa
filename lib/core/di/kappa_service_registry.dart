import 'package:get_it/get_it.dart';

/// A central registry for public module services.
/// Use this to expose and look up shared services (Request-Response).
class FKappaServiceRegistry {
  static final GetIt _sl = GetIt.instance;

  /// Register a service implementation for a given interface.
  static void register<T extends Object>(T implementation) {
    if (!_sl.isRegistered<T>()) {
      _sl.registerLazySingleton<T>(() => implementation);
    }
  }

  /// Check if a service is registered.
  static bool isRegistered<T extends Object>() {
    return _sl.isRegistered<T>();
  }

  /// Look up a service by its interface.
  static T get<T extends Object>() {
    return _sl.get<T>();
  }
}
