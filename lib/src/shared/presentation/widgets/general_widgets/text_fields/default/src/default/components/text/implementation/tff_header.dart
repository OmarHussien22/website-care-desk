part of 'imports_text.dart';

class TFFHeader extends TFFTextImp {
  const TFFHeader({
    String? title,
    String? hintTitle,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    Color? backgroundColor,
  }) : super(
          title: title,
          color: color ,
          hintTitle:hintTitle ,
          fontWeight: fontWeight ,
          fontSize: fontSize ,
          backgroundColor: backgroundColor ,
        );

  @override
  TextStyle get getTextStyle {
    return TextStyle(
      color: color?? TFFConstants.color.tFFHeaderTitle,
      fontWeight: fontWeight?? TFFConstants.headerFontWeight,
      fontSize: (fontSize??TFFConstants.headerFontSize).toFS(),
      backgroundColor: backgroundColor?? TFFConstants.color.tFFHeaderBackground,
      fontFamily: AppStrings.fontFamilyUrw,
    );
  }
  @override
  TextStyle get getHintTextStyle {
    return TextStyle(
      color: color?? TFFConstants.color.tFFHeaderTitle,
      fontWeight: fontWeight?? TFFConstants.hintFontWeight,
      fontSize: (fontSize??TFFConstants.hintFontSize).toFS(),
      backgroundColor: backgroundColor?? TFFConstants.color.tFFHeaderBackground,
      fontFamily: AppStrings.fontFamilyUrw,
    );
  }
}
