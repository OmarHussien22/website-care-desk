import 'package:flutter/material.dart';

import '../../../../../core/app/app_settings.dart';
import '../../../../../core/constants/decorations/app_insets.dart';
import '../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../core/constants/strings/assets/app_images.dart';
import '../../../../../core/services/helper.dart';
import '../../../../../core/services/lang/translate_extention.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../general_widgets/image/generic_image/src/generic_image_lib.dart';
import '../../general_widgets/image/generic_image/src/options/image_options.dart';
import '../../general_widgets/text/custom_text_lib.dart';
import 'imports_illustration_builder.dart';

class BlockedAccPage extends StatelessWidget {
  const BlockedAccPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IllustrationPageBuilder(
            title: "blocked_title".toTr(),
            body: "blocked_sub_title".toTr(),
            imageUrl: AppImages.block,
          ),
          24.ESH(),
          Padding(
            padding: AppInsets.defaultScreenHorizontal,
            child: ButtonDefault(
              onPressed: () {
                Helper.launcher
                    .launchToWhatsApp(AppSettings.contactUsWhatsApp);
              },
              height: 60.toH(),
              color: const Color(0xff3FCC80),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.toW()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomText("contact_with_whats".toTr(),
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FW.normal),
                    ),
                    71.ESW(),
                    ImageGeneric.asset(
                      url: AppIcons.whatsappIcon,
                      options: const ImageOptions(
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          16.ESH(),
          Padding(
            padding: AppInsets.defaultScreenHorizontal,
            child: ButtonDefault(
              onPressed: () {
                Helper.launcher.launchToPhone(AppSettings.contactUsPhone);
              },
              height: 60.toH(),
              color: const Color(0xff5071EB),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.toW()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomText("contact_with_phone".toTr(),
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FW.normal),
                    ),
                    71.ESW(),
                    ImageGeneric.asset(
                      url: AppIcons.phone,
                      options: ImageOptions(
                        height: 24.toH(),
                        width: 24.toW(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
