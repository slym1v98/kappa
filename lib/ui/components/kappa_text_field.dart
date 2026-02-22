import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// A smart text field that adapts to the current platform.
///
/// On Android: Renders a Material 3 [TextField].
/// On iOS: Renders a [CupertinoTextField].
class FKappaTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const FKappaTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: const TextStyle(
                fontSize: 13,
                color: CupertinoColors.systemGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
          ],
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: CupertinoColors.secondarySystemBackground,
              borderRadius: BorderRadius.circular(8),
              border: errorText != null
                  ? Border.all(color: CupertinoColors.systemRed)
                  : null,
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 4),
            Text(
              errorText!,
              style: const TextStyle(color: CupertinoColors.systemRed, fontSize: 12),
            ),
          ],
        ],
      );
    }

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        errorText: errorText,
        border: const OutlineInputBorder(),
        filled: true,
      ),
    );
  }
}
