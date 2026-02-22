import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FKappaSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const FKappaSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      );
    }
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );
  }
}
