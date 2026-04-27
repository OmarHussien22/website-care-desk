import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';

class ButtonClose extends StatelessWidget {
  final VoidCallback? onTap;

  const ButtonClose({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Get.back();
          },
      child: Container(
        height: 25.toH(),
        width: 25.toH(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.toRad()),
          // color: AppColors.get.grey.toOpacityColor(.3),
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: AppColors.get.black,
            size: 24.toRad(),
          ),
        ),
      ),
    );
  }
}
