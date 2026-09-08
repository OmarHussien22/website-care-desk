import 'package:coursaty/src/landing/core/animations/app_animations.dart';
import 'package:coursaty/src/landing/core/animations/fade_in_on_scroll.dart';
import 'package:flutter/widgets.dart';

/// Wraps each child in [FadeInOnScroll] with incremental stagger delays.
class StaggeredChildren extends StatelessWidget {
  const StaggeredChildren({
    super.key,
    required this.children,
    this.staggerStep = AppAnimations.staggerStep,
    this.initialDelay = Duration.zero,
  });

  final List<Widget> children;
  final Duration staggerStep;
  final Duration initialDelay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < children.length; i++)
          FadeInOnScroll(
            delay: initialDelay + staggerStep * i,
            child: children[i],
          ),
      ],
    );
  }
}
