import 'package:flutter/material.dart';
import 'package:coursaty/src/core/core_imports.dart';

extension CurrencyExt on String? {
  /// Returns a Widget based on the currency text. 
  /// If it matches "Saudi Riyal" in Arabic or English, it returns an Icon.
  Widget toCurrencyWidget({FW fontWeight = FW.semiBold, Color? color, double fontSize = 14}) {
    if (this == null || this!.isEmpty) return const SizedBox.shrink();

    // Mapping currency strings to specific icons/widgets
    // The strings used here should match what the backend sends.
    if (this == 'ريال سعودي' || this == 'ريال') {
      return ImageGeneric.asset(
        url: AppIcons.sarArabicIcon,
        options: ImageOptions(
          height:  fontSize.toH(),
          width: fontSize.toH(),
          color: color,
        ),
      );
    } else if (this == 'Saudi Riyal' || this == 'SAR' || this == 'SR' ) {
      return ImageGeneric.asset(
        url: AppIcons.sarEnglishIcon,
        options: ImageOptions(
          height: fontSize.toH(),
          width: fontSize.toH(),
          color: color,
        ),
      );
    }

    // Fallback: Return the text itself if no mapping is found
    return CustomText(
      this!,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
    );
  }
}
