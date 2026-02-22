# Changelog

## 1.0.0

The initial stable release of the fkappa Framework. 

### Features
- **Clean Architecture Foundation:** Enforced through `BaseUseCase`, `BaseRepository`, and `Failure` classes.
- **Independent Module System:** `FKappaModule` interface for self-contained feature development with encapsulated Routing and DI.
- **Inter-module Communication:** Reactive `FKappaEventBus` and direct `FKappaServiceRegistry` for decoupled communication.
- **Adaptive UI Kit:** A complete set of "Smart Components" (`FKappaButton`, `fkappaTextField`, `FKappaCard`, `fkappaListTile`, etc.) that adapt to Material 3 (Android) and HIG (iOS).
- **Persistence:** Integrated `BaseHydratedBloc` for automatic state persistence.
- **Networking:** Standardized `FKappaDio` with built-in API Mocking and Error Handling.
- **Responsive Toolkit:** `FKappaResponsive` mixin for Mobile, Tablet, and Desktop adaptive layouts.
- **Middleware System:** `AuthMiddleware` and `GuestMiddleware` for robust route protection.
- **Developer Experience:** `fkappa CLI` for generating boilerplate modules and `FKappaBlocObserver` for global monitoring.
- **Stability:** Comprehensive test coverage for all core framework components and integration scenarios.

## 0.1.0

- Initial prototype with core architecture and event bus.
