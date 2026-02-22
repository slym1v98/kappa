import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Provides standardized layout and theming helpers for responsive designs.
mixin FKappaResponsive {
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

/// Extends the Material Theme with FKappa specific tokens.
class FKappaThemeExtension extends ThemeExtension<FKappaThemeExtension> {
  final Color brandColor;
  final double defaultRadius;

  const FKappaThemeExtension({
    required this.brandColor,
    this.defaultRadius = 8.0,
  });

  @override
  FKappaThemeExtension copyWith({Color? brandColor, double? defaultRadius}) {
    return FKappaThemeExtension(
      brandColor: brandColor ?? this.brandColor,
      defaultRadius: defaultRadius ?? this.defaultRadius,
    );
  }

  @override
  FKappaThemeExtension lerp(ThemeExtension<FKappaThemeExtension>? other, double t) {
    if (other is! FKappaThemeExtension) return this;
    return FKappaThemeExtension(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      defaultRadius: (defaultRadius + (other.defaultRadius - defaultRadius) * t),
    );
  }

  static FKappaThemeExtension of(BuildContext context) {
    return Theme.of(context).extension<FKappaThemeExtension>()!;
  }
}
