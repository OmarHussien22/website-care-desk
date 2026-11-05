import '../../../../core/services/lang/localization_services.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/landing_colors.dart';
import '../../../core/typography/text_role.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A real button supports focus, keyboard activation, and pointer feedback.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key, this.onSurface = false});
  final bool onSurface;

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationServices.currentLanguageKey == 1;
    final foreground = onSurface
        ? LandingColors.textPrimary
        : LandingColors.onBrand;
    return Semantics(
      label: 'nav.language.switch'.tr,
      child: TextButton.icon(
        onPressed: LocalizationServices.toggleLanguage,
        style: TextButton.styleFrom(
          foregroundColor: foreground,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm.resolve(context),
            vertical: AppSpacing.xs.resolve(context),
          ),
        ),
        icon: const Icon(Icons.language_rounded),
        label: CustomText(
          isArabic ? 'English' : 'العربية',
          role: TextRole.bodySM,
          color: foreground,
        ),
      ),
    );
  }
}
