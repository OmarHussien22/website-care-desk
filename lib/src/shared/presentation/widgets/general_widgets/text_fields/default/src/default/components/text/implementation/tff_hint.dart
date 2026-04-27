part of 'imports_text.dart';

class TFFHint extends TFFTextImp {
  const TFFHint({
    String? title,
    Color? color,

    FontWeight? fontWeight,
    double? fontSize,
    Color? backgroundColor,
  }) : super(
          title: title,
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          backgroundColor: backgroundColor,
        );

  @override
  TextStyle get getTextStyle {
    return TextStyle(
      color: color ?? TFFConstants.color.tFFHintTitle,

      fontWeight: fontWeight ?? TFFConstants.hintFontWeight,
      fontSize: (fontSize ?? TFFConstants.hintFontSize).toFS(),
      backgroundColor: backgroundColor ?? TFFConstants.color.transparent,
      fontFamily: AppStrings.fontFamilyUrw,
    );
  }
}
