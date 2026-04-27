part of 'imports_themes.dart';

final ThemeData _darkTheme = _defaultTheme.copyWith(
  useMaterial3: false,
  brightness: Brightness.dark,
  appBarTheme: getAppBarTheme(isDark: true),
  colorScheme: GetColorScheme.dark,
);
