import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:flutter/widgets.dart';

/// A grid that adapts its column count per breakpoint.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.columns = const Responsive<int>(
      mobile: 1,
      tablet: 2,
      laptop: 3,
      desktop: 4,
    ),
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
  });

  final List<Widget> children;

  /// Number of columns per breakpoint tier.
  final Responsive<int> columns;

  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final cols = columns.resolve(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final totalSpacing = crossAxisSpacing * (cols - 1);
        final itemWidth = (totalWidth - totalSpacing) / cols;

        final rows = <Widget>[];
        for (var i = 0; i < children.length; i += cols) {
          final rowChildren = <Widget>[];
          for (var j = 0; j < cols; j++) {
            final index = i + j;
            if (index < children.length) {
              rowChildren.add(SizedBox(width: itemWidth, child: children[index]));
            } else {
              rowChildren.add(SizedBox(width: itemWidth));
            }
            if (j < cols - 1) {
              rowChildren.add(SizedBox(width: crossAxisSpacing));
            }
          }
          rows.add(Row(children: rowChildren));
          if (i + cols < children.length) {
            rows.add(SizedBox(height: mainAxisSpacing));
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}
