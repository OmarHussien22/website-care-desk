import 'package:flutter/material.dart';

/// Subtle animated gradient background primitive for hero/CTA sections.
class GradientShimmer extends StatefulWidget {
  const GradientShimmer({
    super.key,
    required this.child,
    required this.colors,
    this.duration = const Duration(seconds: 4),
  });

  final Widget child;
  final List<Color> colors;
  final Duration duration;

  @override
  State<GradientShimmer> createState() => _GradientShimmerState();
}

class _GradientShimmerState extends State<GradientShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _beginAlign;
  late Animation<AlignmentGeometry> _endAlign;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _beginAlign = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _endAlign = AlignmentTween(
      begin: Alignment.bottomRight,
      end: Alignment.topRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: _beginAlign.value,
            end: _endAlign.value,
            colors: widget.colors,
          ),
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
