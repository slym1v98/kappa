import 'package:flutter/widgets.dart';

/// Standard durations and curves for FKappa animations.
class FKappaAnimationConstants {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 800);

  static const Curve standardEasing = Curves.easeInOutCubic;
  static const Curve emphasizeEasing = Curves.elasticOut;
  static const Curve decelerateEasing = Curves.decelerate;
}

/// Common animation types supported by FKappa.
enum FKappaAnimationType { fade, scale, slideInUp, slideInDown, slideInLeft, slideInRight }

/// A declarative wrapper for adding animations to any widget.
class FKappaAnimatedView extends StatefulWidget {
  final Widget child;
  final FKappaAnimationType type;
  final Duration duration;
  final Duration delay;
  final double offset; // For slide animations
  final bool animate;

  const FKappaAnimatedView({
    super.key,
    required this.child,
    this.type = FKappaAnimationType.fade,
    this.duration = FKappaAnimationConstants.medium,
    this.delay = Duration.zero,
    this.offset = 30.0,
    this.animate = true,
  });

  @override
  State<FKappaAnimatedView> createState() => _fkappaAnimatedViewState();
}

class _fkappaAnimatedViewState extends State<FKappaAnimatedView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.65, curve: Curves.easeIn)),
    );

    _scale = Tween<double>(begin: widget.type == FKappaAnimationType.scale ? 0.8 : 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: FKappaAnimationConstants.emphasizeEasing),
    );

    _slide = _getSlideTween().animate(
      CurvedAnimation(parent: _controller, curve: FKappaAnimationConstants.decelerateEasing),
    );

    if (widget.animate) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  Tween<Offset> _getSlideTween() {
    switch (widget.type) {
      case FKappaAnimationType.slideInUp:
        return Tween<Offset>(begin: Offset(0, widget.offset), end: Offset.zero);
      case FKappaAnimationType.slideInDown:
        return Tween<Offset>(begin: Offset(0, -widget.offset), end: Offset.zero);
      case FKappaAnimationType.slideInLeft:
        return Tween<Offset>(begin: Offset(-widget.offset, 0), end: Offset.zero);
      case FKappaAnimationType.slideInRight:
        return Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset.zero);
      default:
        return Tween<Offset>(begin: Offset.zero, end: Offset.zero);
    }
  }

  @override
  void didUpdateWidget(FKappaAnimatedView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _controller.forward();
    } else if (!widget.animate && oldWidget.animate) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _slide.value,
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
