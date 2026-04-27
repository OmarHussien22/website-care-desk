part of 'imports_text.dart';

class TFFError extends TFFTextImp {
   const TFFError({
    String? title,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    Color? backgroundColor,
     double? constraintsHeight,
     double? constraintsWidth,
  }) : super(
            title: title,
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            backgroundColor: backgroundColor
   );

  @override
  TextStyle get getTextStyle {
    return TextStyle(
      color: color??TFFConstants.color.tTFErrorText,
      fontWeight: fontWeight??TFFConstants.errorFontWeight,
      fontSize: (fontSize??TFFConstants.errorFontSize).toFS(),
      backgroundColor: backgroundColor??TFFConstants.color.transparent
    );
  }
}
