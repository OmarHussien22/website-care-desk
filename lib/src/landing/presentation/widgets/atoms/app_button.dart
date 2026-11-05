import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/landing_colors.dart';
import '../../../core/typography/text_role.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, ghost }

/// Shared keyboard-accessible landing action with theme-aware variants.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.leadingIcon,
    this.trailingIcon,
  });
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final primary = variant == AppButtonVariant.primary;
    final foreground = primary ? LandingColors.onBrand : LandingColors.accent;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foreground,
        backgroundColor: primary
            ? LandingColors.accent
            : variant == AppButtonVariant.secondary
            ? LandingColors.surfaceElevated
            : null,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.resolve(context),
          vertical: AppSpacing.sm.resolve(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm.resolve(context)),
          side: variant == AppButtonVariant.secondary
              ? BorderSide(color: LandingColors.borderSubtle)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon case final icon?) ...[
            icon,
            SizedBox(width: AppSpacing.xs.resolve(context)),
          ],
          Flexible(
            child: CustomText(
              label,
              role: TextRole.button,
              color: foreground,
              textAlign: TextAlign.center,
            ),
          ),
          if (trailingIcon case final icon?) ...[
            SizedBox(width: AppSpacing.xs.resolve(context)),
            icon,
          ],
        ],
      ),
    );
  }
}
