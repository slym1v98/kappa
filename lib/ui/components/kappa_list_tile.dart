import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// A smart list item that adapts to the current platform.
///
/// On Android: Renders a Material 3 [ListTile].
/// On iOS: Renders a [CupertinoListTile] or custom row.
class FKappaListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  const FKappaListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.separator.withOpacity(0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 17,
                        color: CupertinoColors.label,
                      ),
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.secondaryLabel,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 8),
                trailing!,
              ],
              if (showChevron) ...[
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.chevron_right,
                  size: 16,
                  color: CupertinoColors.tertiaryLabel,
                ),
              ],
            ],
          ),
        ),
      );
    }

    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: showChevron && trailing == null
          ? const Icon(Icons.chevron_right)
          : trailing,
      onTap: onTap,
    );
  }
}
