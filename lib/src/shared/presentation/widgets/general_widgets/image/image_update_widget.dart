import 'dart:io';
import '../../../../../core/constants/strings/assets/app_icons.dart';
import '../../../../../core/utils/extensions/basic_op_extensions.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../managers/user_controller.dart';
import 'generic_image/generic_image.dart';

class ImageUpdateWidget extends StatelessWidget {
  final File? pickedImage;
  final VoidCallback pickImage;
  final bool isEdit;

  const ImageUpdateWidget({
    super.key,
    required this.pickedImage,
    required this.pickImage,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          pickedImage != null
              ? Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.get.white,
                      width: 2,
                    ),
                  ),
                  child: Image.file(
                    File((pickedImage?.path).noneNull),
                    width: 100.toW(),
                    height: 100.toH(),
                    fit: BoxFit.cover,
                  ),
                )
              : ImageGeneric.network(
                  url: (UserController.get.user?.image).noneNull,
                  options: const ImageOptions(radius: 100),
                ),

          // ImageGeneric.asset(Assets.uploadImage,
          //     width: 32, height: 32) ,
          if (isEdit)
            GestureDetector(
              onTap: pickImage,
              child: ImageGeneric.asset(
                url: AppIcons.add,
                options: ImageOptions(radius: 32.toRad()),
              ),
            ),
        ],
      ),
    );
  }
}
