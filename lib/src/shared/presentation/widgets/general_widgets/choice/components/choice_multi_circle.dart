import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';

import '../../../builders/conditional_builder.dart';

class ChoiceMultiCircle extends StatelessWidget {
  final bool isActive;

  const ChoiceMultiCircle({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: isActive,
      onBuild: Container(
        width: 20.0.toW(),
        height: 20.0.toH(),
        decoration: BoxDecoration(
          color: AppColors.get.primary,
          borderRadius: BorderRadius.circular(8.0.toRad()),
          border: Border.all(
            color: AppColors.get.primary,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size:16.toRad(),
            color: AppColors.get.white,
          ),
        ),
      ),
      onFeedBack: Container(
        width: 20.0.toW(),
        height: 20.0.toH(),
        decoration: BoxDecoration(
          color: AppColors.get.white,
          borderRadius: BorderRadius.circular(8.0.toRad()),
          border: Border.all(
            color: AppColors.get.greyLight,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}