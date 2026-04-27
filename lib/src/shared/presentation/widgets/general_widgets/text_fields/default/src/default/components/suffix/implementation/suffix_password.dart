part of 'imports_suffix.dart';

class SuffixPassword extends SuffixImp {
  bool showPassword;
  SuffixPassword({
    double? constraintsHeight,
    double? constraintsWidth,
    Color? color,
    VoidCallback? onTap,
    double? size,
    this.showPassword = false,
  }) : super(
          constraintsHeight: constraintsHeight ?? TFFConstants.suffixConstrainsHeight,
          constraintsWidth: constraintsWidth ?? TFFConstants.suffixConstrainsWidth,
          color: color ?? AppColors.get.tTFSuffixIcon,
          onTap: onTap,
          size: size ?? TFFConstants.suffixIconSize,
        );

  @override
  Widget render(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 10.0.toW(), end: 10.0.toW()),
        child: Icon(
          showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: color,
          size: size?.toW(),
        ),
      ),
    );
  }
}
