import 'dart:io';

import '../../styles/colors/app_colors.dart';
import '../lang/translate_extention.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperService {
  ImageCropperService._();

  static final ImageCropperService instance = ImageCropperService._();

  Future<File?> cropImage(File image) async {
    final ImageCropper imageCropper = ImageCropper();
    final CroppedFile? croppedImage = await imageCropper.cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'image_selection'.toTr(),
          toolbarColor: AppColors.get.primary,
          toolbarWidgetColor: AppColors.get.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'image_selection'.toTr(),
        ),
      ],
    );
    return croppedImage != null ? File(croppedImage.path) : null;
  }
}
