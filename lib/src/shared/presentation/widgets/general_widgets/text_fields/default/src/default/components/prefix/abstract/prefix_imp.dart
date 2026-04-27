import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text_fields/default/src/default/components/render_interface.dart';
import 'package:flutter/material.dart';

abstract class PrefixImp extends RenderInterface {
  final String? title;
  final String? iconImage;
  final IconData? iconData;
  final Color? color;
  final double? size;
  final double? fontSize;
  final double? scale;
  final FontWeight? fontWeight;
  final Widget? widget;
  final double? constraintsHeight;
  final double? constraintsWidth;
  const PrefixImp({
    this.title,
    this.scale,
    this.constraintsHeight,
    this.constraintsWidth,
    this.iconImage,
    this.iconData,
    this.color,
    this.size,
    this.widget,
    this.fontSize,
    this.fontWeight,
  });

  BoxConstraints? get getBoxConstraints {
    return (constraintsHeight != null && constraintsWidth != null)
        ? BoxConstraints(
            maxHeight: (constraintsHeight)!.toH(),
            maxWidth: (constraintsWidth)!.toW(),
          )
        : null;
  }
}
