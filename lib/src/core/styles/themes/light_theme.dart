part of 'imports_themes.dart';

final ThemeData _lightTheme = _defaultTheme.copyWith(
  useMaterial3: false,
  brightness: Brightness.light,
  appBarTheme: getAppBarTheme(isDark: false),
  colorScheme: GetColorScheme.light,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    errorStyle: TextStyle(
      color: AppColors.get.error,
      fontSize: 12.toFS(),
      fontFamily: AppStrings.fontFamilyMontserrat,
    ),
    fillColor: AppColors.get.tTFActiveBackGround,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    errorMaxLines: 2,
  ),
  scaffoldBackgroundColor: AppColors.get.background,
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.get.white,
    unselectedLabelColor: AppColors.get.tabBarlUnselectedLable,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.get.primary,
    ),
  ),
);
