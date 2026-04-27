import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/render_interface.dart';
import 'package:flutter/material.dart';

abstract class SuffixImp extends RenderInterface {
  final String? title;
  final String? iconImage;
  final IconData? iconData;
  final Color? color;
  final double? size;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? widget;
  final VoidCallback? onTap;
  final double? scale;
  final double? constraintsHeight;
  final double? constraintsWidth;
  final bool? isFlipped;

  const SuffixImp({
    this.title,
    this.constraintsHeight,
    this.constraintsWidth,
    this.onTap,
    this.iconImage,
    this.iconData,
    this.color,
    this.size,
    this.widget,
    this.fontSize,
    this.fontWeight,
    this.isFlipped,
    this.scale,
  });

  BoxConstraints? get getBoxConstraints {
    return BoxConstraints(
      maxHeight: constraintsHeight!.toH(),
      maxWidth: constraintsWidth!.toW(),
    );
  }
}
