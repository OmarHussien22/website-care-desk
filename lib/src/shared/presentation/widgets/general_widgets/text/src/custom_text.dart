part of 'imports_text.dart';

class CustomText extends StatelessWidget {
  //<editor-fold desc="Constructor Properties">
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final double? letterSpacing;
  final bool isBold;
  final bool textShadow;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool isOverFlow;
  final int? maxLines;
  final double? textHeight;
  final CustomTextDecoration decoration;
  final String? fontFamily;
  final TextAlign? textAlign;
  final FW fontWeight;
  final TextRole? role;

  /// When true (default) the raw [fontSize] is scaled via screenutil (`.sp`).
  /// Pass `false` to use [fontSize] as a fixed logical-px value — used by the
  /// landing page, whose typography is already breakpoint-responsive and must
  /// not be double-scaled. Ignored when [role] is set (roles never scale).
  final bool scaleFont;

  const CustomText(
    this.label, {
    Key? key,
    this.color,
    this.fontSize = 16,
    this.fontWeight = FW.regular,
    this.isBold = false,
    this.isOverFlow = false,
    this.isUpperCase = false,
    this.padding,
    this.maxLines,
    this.decoration = CustomTextDecoration.none,
    this.textHeight,
    this.fontFamily,
    this.textAlign,
    this.textShadow = false,
    this.backgroundColor,
    this.letterSpacing,
    this.role,
    this.scaleFont = true,
  }) : super(key: key);

//</editor-fold>
  //<editor-fold desc="Subtitle Text">
  /// Build Subtitle Text
  factory CustomText.subtitle(
    String label, {
    Key? key,
    Color? color,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 14.0,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    FW fontWeight = FW.regular,
  }) =>
      CustomText(
        label,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        backgroundColor: backgroundColor,
        color: color ?? AppColors.get.lightText,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  //</editor-fold>
  //<editor-fold desc="Light Text">

  factory CustomText.light(
    String label, {
    Key? key,
    Color? color,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 12.0,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    FW fontWeight = FW.light,
  }) =>
      CustomText(
        label,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        backgroundColor: backgroundColor,
        color: color ?? AppColors.get.hintTitle,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  //</editor-fold>
  //<editor-fold desc="Header Text">
  /// Build Header Text
  factory CustomText.header(
    String label, {
    Key? key,
    double fontSize = 25.0,
    FW fontWeight = FW.semiBold,
    Color? color,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
  }) =>
      CustomText(
        label,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        color: color ?? AppColors.get.primary,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  //</editor-fold>

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle;
    if (role != null) {
      baseStyle = AppTextStyles.of(context, role!, color: color ?? AppColors.get.titleText);
    } else {
      baseStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
            color: color ?? AppColors.get.titleText,
            backgroundColor: backgroundColor,
            fontSize: scaleFont ? (fontSize ?? 16).toFS() : (fontSize ?? 16),
            fontWeight: customTextFw(fontWeight),
            decoration: customTextDecoration(decoration),
            height: textHeight,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? AppStrings.fontFamilyUrw,
            shadows: textShadow
                ? [
                    Shadow(
                      blurRadius: 0.8.toRad(),
                      color: Colors.black,
                      offset: const Offset(1, 1),
                    )
                  ]
                : null,
          );
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        customTextLabel(label: label, isUpperCase: isUpperCase),
        textScaler: TextScaler.noScaling,
        style: baseStyle,
        textAlign: textAlign,
        overflow: isOverFlow ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
      ),
    );
  }
}




///todo :check the direct of row

class GradientText extends StatelessWidget {
  const GradientText({
    Key? key,
    required this.text,
    this.color,
    this.gradient,
    this.fontSize,
    this.fontWeight = FW.regular,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final Color? color;
  final Gradient? gradient;
  final double? fontSize;
  final FW fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return color == null
        ? ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) =>
            (gradient??AppColors.get.defaultLinearColor ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
        child: CustomText(
          text,
          color: color ?? AppColors.get.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
          textAlign: textAlign,
        ))
        : CustomText(
      text,
      color: color ?? AppColors.get.white
      ,
      fontSize: fontSize,
      textAlign: textAlign,
      fontWeight: fontWeight,
    );
  }
}
