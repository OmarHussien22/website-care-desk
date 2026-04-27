part of 'imports_text.dart';

class TFFLabel extends TFFTextImp {
  const TFFLabel({
    String? title,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    Color? backgroundColor,
  }) : super(
          title: title,
          color: color ,
          fontWeight: fontWeight ,
          fontSize: fontSize,
          backgroundColor: backgroundColor ,
        );

  @override
  TextStyle? get getTextStyle {
    return TextStyle(
      color: color?? TFFConstants.color.tFFLabelTitle,
      fontWeight: fontWeight?? TFFConstants.headerFontWeight,
      fontSize: (fontSize ?? TFFConstants.headerFontSize).toFS(),
      backgroundColor: backgroundColor?? TFFConstants.color.tFFLabelBackground,
    );
  }
}
