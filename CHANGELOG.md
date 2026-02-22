# Changelog

## 1.0.0

The initial stable release of the Kappa Framework. 

### Features
- **Clean Architecture Foundation:** Enforced through `BaseUseCase`, `BaseRepository`, and `Failure` classes.
- **Independent Module System:** `KappaModule` interface for self-contained feature development with encapsulated Routing and DI.
- **Inter-module Communication:** Reactive `KappaEventBus` and direct `KappaServiceRegistry` for decoupled communication.
- **Adaptive UI Kit:** A complete set of "Smart Components" (`KappaButton`, `KappaTextField`, `KappaCard`, `KappaListTile`, etc.) that adapt to Material 3 (Android) and HIG (iOS).
- **Persistence:** Integrated `BaseHydratedBloc` for automatic state persistence.
- **Networking:** Standardized `KappaDio` with built-in API Mocking and Error Handling.
- **Responsive Toolkit:** `KappaResponsive` mixin for Mobile, Tablet, and Desktop adaptive layouts.
- **Middleware System:** `AuthMiddleware` and `GuestMiddleware` for robust route protection.
- **Developer Experience:** `Kappa CLI` for generating boilerplate modules and `KappaBlocObserver` for global monitoring.
- **Stability:** Comprehensive test coverage for all core framework components and integration scenarios.

## 0.1.0

- Initial prototype with core architecture and event bus.
