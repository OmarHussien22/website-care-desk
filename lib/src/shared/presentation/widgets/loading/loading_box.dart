import 'package:coursaty/src/core/utils/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/colors/app_colors.dart';
import 'app_loading.dart';
import 'loading.dart';

class LoadingBox extends StatelessWidget {
  final Loading? loading;
  final Color? color;
  

  /// ratio of the screens height media query
  final double heightRatio;

  final double? width;

  final bool isFullScreen;
  final bool hasShadow;

  const LoadingBox({
    super.key,
    this.loading,
    this.color,
    this.heightRatio = 1,
    this.width,
    this.isFullScreen = false,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: isFullScreen
          ? MediaQuery.sizeOf(context).height
          : MediaQuery.sizeOf(context).height * heightRatio,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      // width: MediaQuery.sizeOf(context)..width,
      // height: MediaQuery.sizeOf(context)..height,
      decoration: BoxDecoration(
        color: color,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: AppColors.get.primary.toOpacityColor(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  blurStyle: BlurStyle.outer,
                ),
              ]
            : null,
      ),
      child: loading ?? const AppLoader(),
    );
  }
}
