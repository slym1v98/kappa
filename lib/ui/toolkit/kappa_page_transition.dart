import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'kappa_animation.dart';

/// A helper class to create professional page transitions for GoRouter.
class FKappaPageTransition {
  static CustomTransitionPage<T> fade<T>({
    required Widget child,
    LocalKey? key,
    Duration duration = FKappaAnimationConstants.fast,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static CustomTransitionPage<T> slideUp<T>({
    required Widget child,
    LocalKey? key,
    Duration duration = FKappaAnimationConstants.medium,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .chain(CurveTween(curve: FKappaAnimationConstants.standardEasing)),
          ),
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage<T> zoom<T>({
    required Widget child,
    LocalKey? key,
    Duration duration = FKappaAnimationConstants.medium,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.8, end: 1.0)
                .chain(CurveTween(curve: FKappaAnimationConstants.emphasizeEasing)),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
