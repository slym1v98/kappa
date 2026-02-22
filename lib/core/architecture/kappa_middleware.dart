import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// The contract for all middlewares in FKappa.
/// A middleware can intercept a navigation and decide to redirect or allow it.
abstract class FKappaMiddleware {
  const FKappaMiddleware();

  /// Logic to decide if the navigation should be redirected.
  /// Returns a path to redirect to, or null to allow navigation.
  FutureOr<String?> handle(BuildContext context, GoRouterState state);
}

/// Protects routes that require a logged-in user.
class AuthMiddleware extends FKappaMiddleware {
  final bool Function() isAuthenticated;
  final String loginPath;

  const AuthMiddleware({
    required this.isAuthenticated,
    this.loginPath = '/login',
  });

  @override
  FutureOr<String?> handle(BuildContext context, GoRouterState state) {
    if (!isAuthenticated()) {
      return loginPath;
    }
    return null;
  }
}

/// Protects routes that should only be accessible to guests (e.g., Login, Register).
class GuestMiddleware extends FKappaMiddleware {
  final bool Function() isAuthenticated;
  final String homePath;

  const GuestMiddleware({
    required this.isAuthenticated,
    this.homePath = '/',
  });

  @override
  FutureOr<String?> handle(BuildContext context, GoRouterState state) {
    if (isAuthenticated()) {
      return homePath;
    }
    return null;
  }
}
