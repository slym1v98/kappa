import 'package:flutter/widgets.dart';

/// Professional 12-column grid system for responsive layouts.
class KappaGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileCols;
  final int tabletCols;
  final int desktopCols;
  final double gutter;

  const KappaGrid({
    super.key,
    required this.children,
    this.mobileCols = 4,
    this.tabletCols = 8,
    this.desktopCols = 12,
    this.gutter = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int cols = mobileCols;
        if (constraints.maxWidth > 800) cols = desktopCols;
        else if (constraints.maxWidth > 450) cols = tabletCols;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: cols,
          mainAxisSpacing: gutter,
          crossAxisSpacing: gutter,
          children: children,
        );
      },
    );
  }
}

/// Design Tokens for consistent spacing and styling.
class KappaDesignTokens {
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationHigh = 8.0;
}
