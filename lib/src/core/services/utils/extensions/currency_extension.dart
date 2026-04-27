import '../../../../../packages_index.dart';
import '../../../../shared/presentation/widgets/general_widgets/image/generic_image/generic_image.dart';
import '../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import '../../../constants/strings/assets/app_icons.dart';
import '../../../utils/extensions/screen_spaces_extension.dart';

extension CurrencyExt on String? {
  /// Returns a Widget based on the currency text.
  /// If it matches "Saudi Riyal" in Arabic or English, it returns an Icon.
  Widget toCurrencyWidget({
    FW fontWeight = FW.semiBold,
    Color? color,
    double fontSize = 14,
  }) {
    final value = this;
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    // Mapping currency strings to specific icons/widgets
    // The strings used here should match what the backend sends.
    if (value == 'ريال سعودي' || value == 'ريال') {
      return ImageGeneric.asset(
        url: "AppIcons.sarArabicIcon",
        options: ImageOptions(
          height: fontSize.toH(),
          width: fontSize.toH(),
          color: color,
        ),
      );
    } else if (value == 'Saudi Riyal' || value == 'SAR' || value == 'SR') {
      return ImageGeneric.asset(
        url: "AppIcons.sarEnglishIcon",
        options: ImageOptions(
          height: fontSize.toH(),
          width: fontSize.toH(),
          color: color,
        ),
      );
    }

    // Fallback: Return the text itself if no mapping is found
    return CustomText(
      value,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
    );
  }
}
