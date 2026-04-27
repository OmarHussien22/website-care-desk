import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/colors/app_colors.dart';

/// Creates a Divider with different styles : faded ,semi ,normal

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XDivider.normal(
      verticalPadding: 16.toH(),
      height: 1.toH(),
      horizontalPadding: 10.toW(),
      color: AppColors.get.cardBorder,
    );
  }
}

class XDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double opacity;
  final double horizontalPadding;
  final double verticalPadding;

  const XDivider._({
    Key? key,
    this.height = 1.0,
    this.color,
    this.opacity = 1.0,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
  }) : super(key: key);

  /// Normal Divider with opacity = 1
  factory XDivider.normal({
    double height = 1.0,
    Color? color,
    double horizontalPadding = 0.0,
    double verticalPadding = 0.0,
  }) => XDivider._(
    opacity: 1,
    height: height,
    color: color,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );

  /// Divider with opacity = 0.5
  factory XDivider.semiFaded({
    double height = 1.0,
    Color? color,
    double horizontalPadding = 0.0,
    double verticalPadding = 0.0,
  }) => XDivider._(
    opacity: 0.5,
    height: height,
    color: color,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );

  /// Divider with opacity = 0.1
  factory XDivider.faded({
    double height = 1.0,
    Color? color,
    double horizontalPadding = 0.0,
    double verticalPadding = 0.0,
  }) => XDivider._(
    opacity: 0.1,
    height: 1.0,
    color: color,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );

  @override
  Widget build(BuildContext context) => _CustomDivider(
    color: color ?? Colors.grey[300],
    height: height.toH(),
    key: key,
    opacity: opacity,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
  );
}

class _CustomDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double opacity;
  final double horizontalPadding;
  final double verticalPadding;

  const _CustomDivider({
    Key? key,
    required this.height,
    this.color,
    required this.opacity,
    required this.horizontalPadding,
    required this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Opacity(
        opacity: opacity,
        child: Container(width: double.infinity, height: height, color: color),
      ),
    );
  }
}

class AppDividerDots extends StatelessWidget {
  final Color? dotColor;
  const AppDividerDots({super.key, this.dotColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(50, (index) {
        return Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 2.toH()),
            decoration: BoxDecoration(color: dotColor ?? AppColors.get.black),
          ),
        );
      }),
    );
  }
}
