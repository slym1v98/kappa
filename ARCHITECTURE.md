# Kappa Framework Architecture Specification

## 1. Overview
Kappa is a highly customizable, modular Flutter framework designed for rapid development of Android and iOS applications. It strictly adheres to **Clean Architecture** principles and leverages **BLoC** for state management, **GoRouter** for navigation, and **GetIt** for dependency injection.

## 2. Core Principles
- **Strict Clean Architecture:** Enforced via Base Classes (`BaseUseCase`, `BaseRepository`, `BaseDataSource`).
- **Modular Design:** Features are encapsulated in self-contained `KappaModule`s.
- **Reactive Communication:** Modules communicate strictly via an **Event Bus** to ensure loose coupling.
- **Hybrid UI System:** Provides both pre-styled "Smart Components" (Material 3 & HIG optimized) and low-level "UI Toolkits" for custom designs.
- **Code Generation:** Heavily utilizes `build_runner` (Freezed, JSON Serializable) for type safety and productivity.

## 3. Project Structure
The framework (and apps built with it) will follow this directory structure:

```
lib/
├── core/                   # Framework Core
│   ├── architecture/       # Base classes (UseCase, Repository, etc.)
│   ├── di/                 # Dependency Injection setup
│   ├── error/              # Standardized Failure/Exception classes
│   ├── event_bus/          # Inter-module communication system
│   └── network/            # KappaDio client & Interceptors
├── ui/                     # UI System
│   ├── components/         # Pre-styled Widgets (KappaButton, KappaCard)
│   ├── toolkit/            # Mixins, Spacing, Typography helpers
│   └── theme/              # Theme configuration (Material 3 / Cupertino)
├── modules/                # Base Module Interfaces
│   └── kappa_module.dart   # The contract every feature module must implement
└── kappa.dart              # Main library export
```

## 4. Module System (`KappaModule`)
Every feature in a Kappa app must be a module.

```dart
abstract class KappaModule {
  /// Unique name for the module (e.g., 'Auth', 'Cart')
  String get name;

  /// Register module-specific routes
  List<RouteBase> get routes;

  /// Register dependencies (BLoCs, UseCases, Repositories)
  void registerDependencies();

  /// Initialize module logic (optional)
  Future<void> init() async {}
}
```

## 5. Clean Architecture Enforcers (Base Classes)

### 5.1. UseCase
Enforces a standard execution API using `Either` for functional error handling.

```dart
abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
```

### 5.2. Repository & DataSource
Standardizes data access patterns.

```dart
abstract class BaseRepository {
  // Common repository logic
}
```

### 5.3. BLoC
Enforces state management patterns.

```dart
abstract class BaseBloc<E, S> extends Bloc<E, S> {
  // Common BLoC logic (e.g., event logging, common error handling)
}
```

## 6. Event Bus System
Modules must not import each other. They communicate by publishing and subscribing to events.

```dart
// Publishing
KappaEventBus.emit(UserLoggedOutEvent());

// Subscribing (in another module)
KappaEventBus.on<UserLoggedOutEvent>().listen((event) {
  _cartRepository.clearCart();
});
```

## 7. UI System (Hybrid)
- **Smart Components:** `KappaButton`, `KappaTextField` automatically render Material or Cupertino styles based on the platform.
- **Toolkit:** `KappaSpacing`, `KappaTypography` mixins allow developers to build custom widgets that stay consistent with the design system.

## 8. Routing (Registry)
Kappa maintains a central `GoRouter` configuration. Modules "donate" their routes to this registry at startup.

```dart
// In KappaApp initialization
final router = GoRouter(
  routes: [
    ...authModule.routes,
    ...productModule.routes,
    ...cartModule.routes,
  ],
);
```
