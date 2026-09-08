part of 'imports_text.dart';

class TFFInput extends TFFTextImp {
  const TFFInput({
    String? title,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    Color? backgroundColor,
  }) : super(
          title: title,
          color: color ,
          fontWeight: fontWeight,
          fontSize: fontSize ,
          backgroundColor:
          backgroundColor,
        );

  @override
  TextStyle? get getTextStyle {
    return TextStyle(
      color: color?? TFFConstants.color.tFFInputTitle,
      fontWeight: fontWeight ?? TFFConstants.headerFontWeight,
      fontSize: (fontSize?? TFFConstants.headerFontSize).toFS(),
      fontFamily: AppStrings.fontFamilyMontserrat,
      backgroundColor: backgroundColor?? TFFConstants.color.tFFInputBackground,
    );
  }
}
