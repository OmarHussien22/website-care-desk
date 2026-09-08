import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Bottom strip: copyright year + a soft gradient divider above.
class FooterBottomStrip extends StatelessWidget {
  const FooterBottomStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final copyright = 'footer.copyright'.tr.replaceFirst('{year}', '$year');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gradient divider: transparent → accent (low alpha) → transparent
        SizedBox(
          width: double.infinity,
          height: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  LandingColors.accentGradientStart.withValues(alpha: 0.45),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
          child: CustomText(
            copyright,
            scaleFont: false,
            fontSize: 12,
            fontWeight: FW.medium,
            fontFamily: 'Montserrat',
            color: LandingColors.textSecondary,
            textAlign: TextAlign.center,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
