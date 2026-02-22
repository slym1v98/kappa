import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// The contract that every feature module in a FKappa application must implement.
///
/// A Module encapsulates a specific feature set (e.g., Auth, Cart, Product).
/// It manages its own Routes, Dependency Injection, and Initialization logic.
abstract class FKappaModule {
  /// The unique name of the module.
  String get name;

  /// The list of routes provided by this module.
  List<RouteBase> get routes;

  /// Whether this module should be loaded only when its routes are accessed.
  bool get isLazy => false;

  /// Register dependencies.
  void registerDependencies(GetIt sl);

  /// Async initialization.
  Future<void> init() async {}
}

