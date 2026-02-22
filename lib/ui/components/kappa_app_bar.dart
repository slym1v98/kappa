import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class KappaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  const KappaAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: title,
        trailing: actions != null ? Row(mainAxisSize: MainAxisSize.min, children: actions!) : null,
        leading: leading,
      );
    }
    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Platform.isIOS ? 44.0 : 56.0);
}
