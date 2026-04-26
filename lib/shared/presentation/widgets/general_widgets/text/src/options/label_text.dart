part of 'imports_text_options.dart';

/// returns in debug mode


String customTextLabel({
  required String label,
  required bool isUpperCase,
}) {
  String labelText = isUpperCase ? label.toUpperCase().toTr() : label.toTr();

    return labelText;

}
