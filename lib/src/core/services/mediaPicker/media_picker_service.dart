part of 'imports_media_picker.dart';

class MediaPickerService {
  MediaPickerService._();

  static final MediaPickerService instance = MediaPickerService._();

  Future<void> pickMediaSheet({
    MediaPickedType type = MediaPickedType.single,
    required Function(File?) onSuccess,
  }) async {
    await Get.bottomSheet(
      SheetMediaPicker(
        type: type,
        onCameraPicked: () async {
          final value = await pickImage(source: ImageSource.camera);
          onSuccess.call(value);
          if (Get.isBottomSheetOpen ?? false) Get.back();
        },
        onGalleryPicked: () async {
          final value = await pickImage(source: ImageSource.gallery);
          onSuccess.call(value);
          if (Get.isBottomSheetOpen ?? false) Get.back();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> pickMultiMediaSheet({
    required Function(List<File?>) onSuccess,
  }) async {
    await Get.bottomSheet(
      SheetMultiMediaPicker(
        onMultiSelect: () async {
          final values = await pickImages();
          if (values.isNotEmpty) onSuccess.call(values);
          if (Get.isBottomSheetOpen ?? false) Get.back();
        },
        onSingleSelect: () async {
          final value = await pickImage(source: ImageSource.gallery);
          if (value != null) onSuccess.call([value]);
          if (Get.isBottomSheetOpen ?? false) Get.back();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<File?> pickImage({
    ImageSource source = ImageSource.camera,
    CameraDevice cameraDevice = CameraDevice.rear,
  }) async {
    File? pickedImage;
    try {
      final XFile? value = await ImagePicker().pickImage(
        source: source,
        preferredCameraDevice: cameraDevice,
        imageQuality: 30,
      );
      if (value != null) {
        pickedImage = File(value.path);
        if (kDebugMode) {
          print('pickedImage is : $pickedImage');
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed To pick an Image because of => $e');
      }
    }

    if (pickedImage != null) {
      printDM(
        'ImageSize ${getFileSizeString(bytes: pickedImage.lengthSync())}',
      );
    }
    return pickedImage;
  }

  Future<List<File>> pickImages({
    CameraDevice cameraDevice = CameraDevice.rear,
  }) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage(imageQuality: 30);
    if (result.isNotEmpty) {
      return result.map((e) => File(e.path)).toList();
    }
    return [];
  }

  Future<List<File>> pickMultipleMedia({
    CameraDevice cameraDevice = CameraDevice.rear,
  }) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultipleMedia(
      imageQuality: 30,
    );
    if (result.isNotEmpty) {
      return result.map((e) => File(e.path)).toList();
    }
    return [];
  }

  Future<File?> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      return File(video.path);
    }
    return null;
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return '0 Bytes';
    const suffixes = [' Bytes', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor();
    return (bytes / pow(1024, i)).toStringAsFixed(decimals) + suffixes[i];
  }
}

enum MediaPickedType { single, multi }
