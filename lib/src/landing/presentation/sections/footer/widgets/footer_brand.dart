import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/presentation/widgets/atoms/brand_logo.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Brand block shown in the footer (logo + tagline).
class FooterBrand extends StatelessWidget {
  const FooterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BrandLogo(height: 40),
        const SizedBox(height: 18),
        CustomText(
          'footer.tagline'.tr,
          scaleFont: false,
          fontSize: 14,
          fontWeight: FW.regular,
          color: LandingColors.textSecondary,
          fontFamily: 'Montserrat',
          textHeight: 1.55,
        ),
      ],
    );
  }
}
