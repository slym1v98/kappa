import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// A smart container that adapts to the current platform.
///
/// On Android: Renders a Material 3 [Card] (Elevated or Filled).
/// On iOS: Renders a [Container] with platform-appropriate decoration.
class FKappaCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const FKappaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      final cardColor = backgroundColor ?? CupertinoColors.systemBackground;
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey4.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: CupertinoColors.separator.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: child,
        ),
      );
    }

    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
