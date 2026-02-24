# Changelog

## 1.0.1

- **Branding Update:** Officially renamed classes and components to **FKappa** for a more professional and consistent identity.
- **Refinement:** Improved internal platform interface handling and naming.
- **Fixes:** Resolved minor export issues in the main library entry point.

## 1.0.0

The initial stable release of the FKappa Framework. 

### Features
- **Clean Architecture Foundation:** Enforced through `BaseUseCase`, `BaseRepository`, and `Failure` classes.
- **Independent Module System:** `FKappaModule` interface for self-contained feature development.
- **Inter-module Communication:** Reactive `FKappaEventBus` and direct `FKappaServiceRegistry`.
- **Adaptive UI Kit:** A complete set of "Smart Components" (`FKappaButton`, `FKappaTextField`, etc.).
- **Persistence:** Integrated `BaseHydratedBloc` for automatic state persistence.
- **Networking:** Standardized `FKappaDio` with Offline-First support.
- **Responsive Toolkit:** `FKappaResponsive` mixin for adaptive layouts.
- **Middleware System:** `AuthMiddleware` and `GuestMiddleware`.
- **Developer Experience:** `FKappa CLI` for code generation and global monitoring.
