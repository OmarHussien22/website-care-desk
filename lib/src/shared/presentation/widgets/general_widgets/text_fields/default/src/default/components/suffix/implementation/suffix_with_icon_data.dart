part of 'imports_suffix.dart';

class SuffixWithIconData extends SuffixImp {
  SuffixWithIconData({
    required IconData iconData,
    Color? color,
    double? size,
    double? scale,
    VoidCallback? onTap,
    double? constraintsHeight,
    double? constraintsWidth,
    bool? isFlipped,
  }) : super(
            iconData: iconData,
            constraintsHeight: constraintsHeight??TFFConstants.suffixConstrainsHeight,
            constraintsWidth: constraintsWidth??TFFConstants.suffixConstrainsWidth,
            color: color ?? AppColors.get.tTFSuffixIcon,
            size: size?? TFFConstants.suffixIconSize,
            scale: scale??TFFConstants.suffixIconScale,
            isFlipped: isFlipped,
            onTap: onTap);

  @override
  Widget render(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 5,left: 5),
        child: Transform.flip(
          flipX: isFlipped ?? false,
          child: Icon(
            iconData,
            color: color,
            size: size?.toW(),
          ),
        ),
      ),
    );
  }
}
