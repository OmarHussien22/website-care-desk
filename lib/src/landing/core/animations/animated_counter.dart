import 'package:coursaty/src/landing/core/animations/app_animations.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Compact-formats [value]: `1_200_000 → "1.2M"`, `40_000 → "40k"`, `250 → "250"`.
String compactCount(int value) {
  if (value >= 1000000) {
    final m = value / 1000000;
    final s = m.toStringAsFixed(m % 1 == 0 ? 0 : 1);
    return '${s}M';
  }
  if (value >= 1000) {
    return '${(value ~/ 1000)}k';
  }
  return '$value';
}

/// Counts up `0 → target` the first time it scrolls into view, then latches.
///
/// Uses the same `visibility_detector` mechanism as [FadeInOnScroll] and
/// honors [MediaQuery.disableAnimations] by rendering the final value at once.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.target,
    this.suffix = '+',
    this.fontSize = 40,
    this.color,
    this.fontWeight = FW.bold,
    this.duration = const Duration(milliseconds: 1200),
  });

  final int target;
  final String suffix;
  final double fontSize;
  final Color? color;
  final FW fontWeight;
  final Duration duration;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _count;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _count = IntTween(begin: 0, end: widget.target).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.entranceCurve),
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered) return;
    if (info.visibleFraction > 0.05) {
      _triggered = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _number(int value) => CustomText(
    '${compactCount(value)}${widget.suffix}',
    scaleFont: false,
    fontSize: widget.fontSize,
    fontWeight: widget.fontWeight,
    fontFamily: 'Montserrat',
    color: widget.color,
  );

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) {
      return _number(widget.target);
    }

    return VisibilityDetector(
      key: ValueKey('counter-${widget.target}-${widget.suffix}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _count,
        builder: (context, _) => _number(_count.value),
      ),
    );
  }
}
