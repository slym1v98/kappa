import 'package:flutter/widgets.dart';

/// Provides standardized spacing constants for consistent layout.
/// Use this mixin in your Widgets or UI classes.
mixin KappaSpacing {
  static const double tiny = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;

  static const SizedBox tinyV = SizedBox(height: tiny);
  static const SizedBox smallV = SizedBox(height: small);
  static const SizedBox mediumV = SizedBox(height: medium);
  static const SizedBox largeV = SizedBox(height: large);
  static const SizedBox extraLargeV = SizedBox(height: extraLarge);

  static const SizedBox tinyH = SizedBox(width: tiny);
  static const SizedBox smallH = SizedBox(width: small);
  static const SizedBox mediumH = SizedBox(width: medium);
  static const SizedBox largeH = SizedBox(width: large);
  static const SizedBox extraLargeH = SizedBox(width: extraLarge);
}
