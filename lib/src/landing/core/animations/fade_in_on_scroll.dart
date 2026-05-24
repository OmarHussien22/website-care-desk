import 'package:coursaty/src/landing/core/animations/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades and slides up [child] the first time it enters the viewport.
///
/// Respects [MediaQuery.disableAnimations] for accessibility.
class FadeInOnScroll extends StatefulWidget {
  const FadeInOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppAnimations.entrance,
    this.curve = AppAnimations.entranceCurve,
    this.slideOffset = 24.0,
  });

  final Widget child;

  /// Optional delay before the animation starts (useful for stagger).
  final Duration delay;

  final Duration duration;
  final Curve curve;

  /// How many logical px to slide up from the initial position.
  final double slideOffset;

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

class _FadeInOnScrollState extends State<FadeInOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _controller, curve: widget.curve);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideOffset / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered) return;
    if (info.visibleFraction > 0.05) {
      _triggered = true;
      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) _controller.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) {
      return widget.child;
    }

    return VisibilityDetector(
      key: widget.key ?? ValueKey(widget.child.hashCode),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      ),
    );
  }
}
