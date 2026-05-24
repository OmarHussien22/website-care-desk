import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:flutter/widgets.dart';

/// A Row that switches to a Column on [collapseAt] breakpoint and below.
class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.collapseAt = ScreenSize.mobile,
    this.spacing = 0,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  /// Breakpoints at or below this tier collapse to a Column.
  final ScreenSize collapseAt;

  /// Gap between children (applied as SizedBox spacing).
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final collapsed = size.index <= collapseAt.index;
    final spaced = _intersperse(children, spacing, collapsed);

    if (collapsed) {
      return Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: spaced,
      );
    }
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spaced,
    );
  }

  static List<Widget> _intersperse(
      List<Widget> children, double spacing, bool vertical) {
    if (spacing == 0 || children.length < 2) return children;
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(vertical
            ? SizedBox(height: spacing)
            : SizedBox(width: spacing));
      }
    }
    return result;
  }
}
