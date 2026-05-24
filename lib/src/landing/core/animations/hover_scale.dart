import 'package:coursaty/src/landing/core/animations/app_animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Web-only hover scale + shadow lift for interactive cards.
/// On non-web platforms, renders the child unchanged.
class HoverScale extends StatefulWidget {
  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.03,
    this.duration = AppAnimations.fast,
  });

  final Widget child;
  final double scale;
  final Duration duration;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return widget.child;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? widget.scale : 1.0,
        duration: widget.duration,
        curve: AppAnimations.standard,
        child: widget.child,
      ),
    );
  }
}
