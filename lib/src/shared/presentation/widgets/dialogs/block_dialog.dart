import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../packages_index.dart';
import '../../../../core/constants/strings/assets/app_images.dart';
import '../../../caches/user_cache.dart';
import '../../controllers/user_controller.dart';
import '../general_widgets/image/generic_image/generic_image.dart';
import '../general_widgets/text/custom_text_lib.dart';

class BlockDialog extends StatefulWidget {
  const BlockDialog({super.key});

  @override
  State<BlockDialog> createState() => _BlockDialogState();
}

class _BlockDialogState extends State<BlockDialog> {
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      UserCache.instance.logout();
      UserController.get.deleteUser();
    } catch (e) {
      debugPrint("Error: $e");
    }
    timer = Timer(const Duration(seconds: 3), () {
      // Get.offAll(() => const MainAuthPage());
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageGeneric.svg(
            url:AppImages.block,
            options: const ImageOptions(height: 150, width: 150),
          ),
          const CustomText(
            "block_dialog_title",
            fontSize: 16,
            textAlign: TextAlign.center,
            fontWeight: FW.semiBold,
          ),
        ],
      ),
    );
  }
}
