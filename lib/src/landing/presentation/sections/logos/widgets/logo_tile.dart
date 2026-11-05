import 'package:coursaty/src/core/services/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/landing/core/spacing/app_spacing.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/data/landing_clients.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LogoTile extends StatelessWidget {
  const LogoTile({super.key, required this.client});
  final LandingClient client;

  @override
  Widget build(BuildContext context) {
    final arabic = Get.locale?.languageCode == 'ar';
    final name = arabic ? client.nameAr : client.nameEn;
    final description = arabic ? client.descriptionAr : client.descriptionEn;
    final asset = client.logoAsset;
    final logoSize = AppSpacing.xl.resolve(context);
    final fallback = Icon(
      Icons.local_hospital_outlined,
      color: LandingColors.accent,
      size: 28.toRad().clamp(24, 36),
    );

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.resolve(context)),
      decoration: BoxDecoration(
        color: LandingColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppSpacing.md.resolve(context)),
        border: Border.all(color: LandingColors.borderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: logoSize,
            width: double.infinity,
            child: asset == null
                ? fallback
                : asset.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                    asset,
                    fit: BoxFit.contain,
                    semanticsLabel: name,
                    errorBuilder: (_, _, _) => fallback,
                  )
                : Image.asset(
                    asset,
                    fit: BoxFit.contain,
                    semanticLabel: name,
                    errorBuilder: (_, _, _) => fallback,
                  ),
          ),
          SizedBox(height: AppSpacing.sm.resolve(context)),
          CustomText(
            name,
            role: TextRole.headingSM,
            color: LandingColors.textPrimary,
            textAlign: TextAlign.center,
          ),
          if (description != null && description.isNotEmpty) ...[
            SizedBox(height: AppSpacing.xs.resolve(context)),
            CustomText(
              description,
              role: TextRole.bodySM,
              color: LandingColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
