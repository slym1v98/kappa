# Kappa Framework v1.0.0 🚀

Kappa is a robust, modular, and highly customizable Flutter framework designed for rapid development of enterprise-grade applications. It strictly follows **Clean Architecture** principles and leverages **BLoC** for state management and **GoRouter** for navigation.

## Key Features
- **Strict Clean Architecture:** Enforced via base classes for Use Cases, Repositories, and Data Sources.
- **Decoupled Modules:** Build features independently with their own Routes, DI, and Logic.
- **Reactive Communication:** Decouple modules using the global `KappaEventBus`.
- **Hybrid UI Kit:** Adaptive components that look native on both Android (Material 3) and iOS (HIG).
- **Persistence:** Automatic state persistence with `BaseHydratedBloc`.
- **Networking:** Standardized `KappaDio` client with built-in API Mocking and Error Handling.
- **Middleware:** Protect your routes with `Auth` and `Guest` guards out of the box.
- **Developer Productivity:** Generate new modules in seconds using the `Kappa CLI`.

## Getting Started

### 1. Add Dependency
Add Kappa to your `pubspec.yaml`:
```yaml
dependencies:
  kappa: ^1.0.0
```

### 2. Launch your App
Use the `KappaApp` widget to initialize your modules:
```dart
void main() {
  runApp(
    KappaApp(
      title: 'My Awesome App',
      modules: [
        AuthModule(),
        ProductModule(),
        SettingsModule(),
      ],
      initialRoute: '/home',
    ),
  );
}
```

### 3. Generate a Module
Create a new feature module in seconds:
```bash
dart run kappa generate module <module_name>
```

## Documentation
For more detailed instructions, please check our [Developer Guide](GUIDE.md) and [Architecture Blueprint](ARCHITECTURE.md).

## Support
Built with ❤️ for rapid high-quality Flutter development.
