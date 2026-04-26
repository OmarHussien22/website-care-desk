import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Wraps [child] with a shimmer skeleton effect while [isLoading] is true.
///
/// Usage: provide [child] with placeholder/fake data that mirrors your real
/// content layout. Skeletonizer renders it as an animated skeleton when
/// [isLoading] is true, then shows the real content when false.
class SkeletonPage extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const SkeletonPage({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: child,
    );
  }
}
