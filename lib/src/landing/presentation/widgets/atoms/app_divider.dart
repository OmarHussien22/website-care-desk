import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:flutter/material.dart';

/// Thin hairline divider using the landing borderSubtle token.
class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.height = 1, this.indent = 0});

  final double height;
  final double indent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: height,
      indent: indent,
      endIndent: indent,
      color: LandingColors.borderSubtle,
    );
  }
}
