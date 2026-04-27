import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/strings/app_strings.dart';
import '../general_widgets/text/custom_text_lib.dart';

class CardAppCredit extends StatelessWidget {
  const CardAppCredit({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              'Made With ❤️ By Crazyidea',
              fontWeight: FW.regular,
              fontSize: 12,
            ),
          ],
        ),
        8.ESH(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              "${AppStrings.appAndroidVersion} اصدار التطبيق  ",
              fontWeight: FW.regular,
              fontSize: 11,
            ),
          ],
        ),
      ],
    );
  }
}
