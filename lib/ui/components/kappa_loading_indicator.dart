import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FKappaLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double radius;

  const FKappaLoadingIndicator({
    super.key,
    this.color,
    this.radius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(color: color, radius: radius);
    }
    return CircularProgressIndicator(
      color: color,
      strokeWidth: 2.0,
    );
  }
}
