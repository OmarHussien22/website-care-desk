import '../../../../core/breakpoints/screen_size.dart';
import '../../../../core/navigation/meddesk_actions.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../widgets/atoms/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroCtaRow extends StatelessWidget {
  const HeroCtaRow({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = AppButton(
      label: 'hero.cta.primary'.tr,
      onPressed: MedDeskActions.openRegistration,
      trailingIcon: const Icon(Icons.arrow_forward_rounded),
    );
    final secondary = AppButton(
      label: 'hero.cta.secondary'.tr,
      onPressed: () => MedDeskActions.scrollTo('product'),
      variant: AppButtonVariant.secondary,
      leadingIcon: const Icon(Icons.play_circle_outline_rounded),
    );
    final gap = AppSpacing.sm.resolve(context);
    if (ScreenSizeX.of(context).isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          primary,
          SizedBox(height: gap),
          secondary,
        ],
      );
    }
    return Wrap(spacing: gap, runSpacing: gap, children: [primary, secondary]);
  }
}
