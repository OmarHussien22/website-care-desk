part of 'imports_colors.dart';

class DarkColor extends ColorInterface {
  @override
  Color get main => const Color(0xff05103C);

  @override
  Color get background => const Color(0xff05103C);

  @override
  Color get activeBackground => const Color(0xe2061349);

  @override
  Color get disabled => const Color(0xff101C43);

  @override
  Color get title => Colors.white;

  @override
  Color get tFFFillColor => const Color(0xff101C43);

  @override
  Color get shadow => const Color(0xff040E35);

  @override
  Color get cardBorder => const Color(0xff101C43);

  @override
  Color get tabBar => main;

  @override
  Color get cardFill => Colors.white12.toOpacityColor(0.05);

  @override
  Color get icon => Colors.white;

  @override
  Color get opposite => Colors.white;

  @override
  Color get onRefreshIndicator => primary.withOpacity(0.8);

  @override
  Color get appBarColorInner => Colors.white;

  // Landing tokens — dark (§9.2 palette)
  @override
  Color get surfaceMuted => const Color(0xff0F172A);
  @override
  Color get surfaceElevated => const Color(0xff1E293B);
  @override
  Color get borderSubtle => const Color(0xff1E293B);
  @override
  Color get accentGradientStart => const Color(0xff0EA5E9);
  @override
  Color get accentGradientEnd => const Color(0xff22D3EE);
  @override
  Color get textPrimary => const Color(0xffF8FAFC);
  @override
  Color get textSecondary => const Color(0xff94A3B8);
  @override
  Color get textInverse => const Color(0xff0F172A);
  @override
  Color get success => const Color(0xff10B981);
}
