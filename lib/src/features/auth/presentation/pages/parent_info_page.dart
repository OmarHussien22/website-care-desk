import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/decorations/app_Insets.dart';
import '../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../core/services/lang_service/translate_extention.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../shared/presentation/widgets/app_bars/appbar_background.dart';
import '../../../../shared/presentation/widgets/general_widgets/buttons/basic/custom_rounded_button.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/app_full_name_field.dart';
import '../../../../shared/presentation/widgets/general_widgets/text_fields/default/src/phone_form_field.dart';
import '../controllers/set_parent_data_controller.dart';

class ParentInfoPage extends StatelessWidget {
  const ParentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SetParentDataController());
    return GetBuilder<SetParentDataController>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              AppbarBackground(
                title: "parent_info_title",
                subtitle: "parent_info_subtitle",
                showBackButton: true,
              ),
              const _ParentInfoBody(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonDefault(
                  title: "confirm".toTr(),
                  isDisabled: controller.isButtonDisabled,
                  onPressed: () {
                    controller.setParentData();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ParentInfoBody extends StatelessWidget {
  const _ParentInfoBody();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SetParentDataController>();
    return Expanded(
      child: SingleChildScrollView(
        padding: AppInsets.defaultScreenALL,
        child: Form(
          key: controller.globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFullNameField(
                controller: controller.parentNameController,
                icon: AppIcons.user,
                withHeader: true,
                headerTitle: "profile_full_name".toTr(),
              ),
              16.ESH(),
              PhoneFormField(
                controller: controller.parentPhoneController,
                onCountryCodeChanged: controller.onCountryCodeParentChange,
                header: "profile_phone_number".toTr(),
                hasCountryCode: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
