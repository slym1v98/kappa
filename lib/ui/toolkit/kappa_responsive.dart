import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Provides standardized layout and theming helpers for responsive designs.
mixin KappaResponsive {
  /// Breakpoints for different devices.
  static const List<Breakpoint> breakpoints = [
    Breakpoint(start: 0, end: 450, name: MOBILE),
    Breakpoint(start: 451, end: 800, name: TABLET),
    Breakpoint(start: 801, end: 1920, name: DESKTOP),
    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  ];

  static bool isMobile(BuildContext context) => ResponsiveBreakpoints.of(context).isMobile;
  static bool isTablet(BuildContext context) => ResponsiveBreakpoints.of(context).isTablet;
  static bool isDesktop(BuildContext context) => ResponsiveBreakpoints.of(context).isDesktop;

  /// Returns a value based on the current breakpoint.
  static T valueByBreakpoint<T>(BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }
}

/// Extends the Material Theme with Kappa specific tokens.
class KappaThemeExtension extends ThemeExtension<KappaThemeExtension> {
  final Color brandColor;
  final double defaultRadius;

  const KappaThemeExtension({
    required this.brandColor,
    this.defaultRadius = 8.0,
  });

  @override
  KappaThemeExtension copyWith({Color? brandColor, double? defaultRadius}) {
    return KappaThemeExtension(
      brandColor: brandColor ?? this.brandColor,
      defaultRadius: defaultRadius ?? this.defaultRadius,
    );
  }

  @override
  KappaThemeExtension lerp(ThemeExtension<KappaThemeExtension>? other, double t) {
    if (other is! KappaThemeExtension) return this;
    return KappaThemeExtension(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      defaultRadius: (defaultRadius + (other.defaultRadius - defaultRadius) * t),
    );
  }

  static KappaThemeExtension of(BuildContext context) {
    return Theme.of(context).extension<KappaThemeExtension>()!;
  }
}
