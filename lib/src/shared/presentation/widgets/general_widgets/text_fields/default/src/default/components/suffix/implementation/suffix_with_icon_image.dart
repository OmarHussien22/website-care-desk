part of 'imports_suffix.dart';

class SuffixWithIconImage extends SuffixImp {
  SuffixWithIconImage({
    required String iconImage,
    Color? color,
    double? size,
    double? scale,
    VoidCallback? onTap,
    double? constraintsHeight,
    double? constraintsWidth,
  }) : super(
          iconImage: iconImage,
    constraintsHeight: constraintsHeight??TFFConstants.suffixConstrainsHeight,
    constraintsWidth: constraintsWidth??TFFConstants.suffixConstrainsWidth,
          color: color ?? AppColors.get.tTFSuffixIcon,
          size: size?? TFFConstants.suffixImageSize,
          onTap: onTap,
          scale: scale ?? TFFConstants.suffixImageSize,
        );

  @override
  Widget render(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(2),
            child: ConditionalBuilder(
              condition: (iconImage ?? "").contains("http"),
              onBuild: ImageIcon(
                NetworkImage("$iconImage"),
                color: color ,
                size: size?.toW(),
              ),
              onFeedBack: ImageIcon(
                AssetImage("$iconImage"),
                color: color ,
                size: size?.toW(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
