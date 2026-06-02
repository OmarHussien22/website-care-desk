import 'package:coursaty/src/core/services/lang/localization_services.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Compact language switcher for the NavBar.
///
/// Displays the *target* language endonym ("العربية" while English is active,
/// "English" while Arabic is active) and toggles the app locale on tap.
/// [Get.updateLocale] rebuilds the whole tree, so reading
/// [LocalizationServices.currentLanguageKey] on build is enough to stay in sync.
class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key, this.onSurface = false});

  /// When `true`, renders for a solid/light surface (drawer, scrolled navbar)
  /// using primary text color. When `false`, renders white for the hero overlay.
  final bool onSurface;

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool _hovered = false;

  void _onTap() => LocalizationServices.toggleLanguage();

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationServices.currentLanguageKey == 1;
    final targetLabel = isArabic ? 'English' : 'العربية';

    final Color fg =
        widget.onSurface ? LandingColors.textPrimary : Colors.white;
    final Color hoverBg = widget.onSurface
        ? LandingColors.accentGradientStart.withValues(alpha: 0.12)
        : Colors.white.withValues(alpha: 0.18);

    return Semantics(
      button: true,
      label: 'nav.language.switch'.tr,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: _onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered ? hoverBg : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language_rounded, size: 18, color: fg),
                const SizedBox(width: 6),
                CustomText(
                  targetLabel,
                  scaleFont: false,
                  fontSize: 14,
                  fontWeight: FW.medium,
                  fontFamily: 'Montserrat',
                  color: fg,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
