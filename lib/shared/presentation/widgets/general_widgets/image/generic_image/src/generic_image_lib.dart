import 'dart:io';

import '../../../../../../../core/services/utils/extensions/color_extension.dart';
import '../generic_image.dart';
import 'parts/image_lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../builders/conditional_builder.dart';
import 'parts/imports_parts.dart';

class ImageGeneric extends StatelessWidget {
  final ImageOptions? options;
  final ImageProvider? imageProvider;
  final bool isAsset;
  final Widget? child;

  const ImageGeneric({
    super.key,
    this.child,
    this.options,
    this.imageProvider,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return child ??
        (imageProvider != null
            ? ImageIcon(
                imageProvider!,
                color: options?.color,
                size: options?.radius,
              )
            : const SizedBox.shrink());
    // return GestureDetector(
    //   onTap: () {
    //     if (options?.previewImage ?? false) {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(
    //           builder: (context) => ImageView(
    //             minScale: options?.previewImageMinScale ?? 0.1,
    //             maxScale: options?.previewImageMaxScale ?? 1.0,
    //             child: child ?? const SizedBox.shrink(),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    //   child: child ??
    //       (imageProvider != null
    //           ? ImageIcon(
    //               imageProvider!,
    //               color: options?.color,
    //               size: options?.radius,
    //             )
    //           : const SizedBox.shrink()),
    // );
  }

  factory ImageGeneric.asset({
    Key? key,
    required String url,
    ImageOptions? options,
  }) {
    return ImageGeneric(
      key: key,
      options: options,
      child: ImageAsset(
        url: url,
        options: options,
      ),
    );
  }
  factory ImageGeneric.lottie({
    Key? key,
    required String url,
    ImageOptions? options,
  }) {
    return ImageGeneric(
      key: key,
      options: options,
      child: ImageLottie(
        url: url,
        options: options,
      ),
    );
  }

  factory ImageGeneric.network({
    Key? key,
    required String url,
    ImageOptions? options,
    bool hasDropShadow = false,
    String? placeHolder,
    VoidCallback? onTap,
  }) {
    return ImageGeneric(
      key: key,
      options: options,
      child: ConditionalBuilder(
        condition: hasDropShadow,
        onBuild: ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColors.get.black.toOpacityColor(.2),
            BlendMode.srcATop,
          ),
          child: ImageNetwork(
            url: url,
            options: options,
            placeHolder: placeHolder,
          ),
        ),
        onFeedBack: ImageNetwork(
          url: url,
          options: options,
          placeHolder: placeHolder,
        ),
      ),
    );
  }

  factory ImageGeneric.file({
    Key? key,
    required File? fileImage,
    ImageOptions? options,
  }) {
    return ImageGeneric(
      key: key,
      options: options,
      child: ConditionalBuilder(
        condition: fileImage != null && fileImage.path != '',
        onBuild: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: options?.backgroundColor,
            borderRadius: options?.borderRadius,
            shape:
                options?.radius != null ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: Image.file(
            fileImage ?? File(''),
            fit: options?.fit,
            height: options?.height,
            width: options?.width,
            scale: options?.scale ?? 1,
            alignment: options?.alignment ?? Alignment.center,
            color: options?.color,
          ),
        ),
        onFeedBack: const SizedBox.shrink(),
      ),
    );
  }

  factory ImageGeneric.svg({
    Key? key,
    required String url,
    ImageOptions? options,
    bool isNetwork = false,
  }) {
    return ImageGeneric(
      key: key,
      options: options,
      child: ImageSvg(
        url: url,
        options: options,
        type: isNetwork ? ImageType.sVGNetwork : ImageType.sVGAsset,
      ),
    );
  }

  static void preview({
    double minScale = 0.01,
    double maxScale = 1,
    ImageType type = ImageType.network,
    required String url,
    ImageOptions? options,
    bool hasHero = false,
  }) {
    Get.to(
      ImageView(
        minScale: minScale,
        maxScale: maxScale,
        child: type == ImageType.network
            ? hasHero
                ? Hero(
                    tag: url,
                    child: ImageGeneric.network(
                      url: url,
                      options: options,
                      hasDropShadow: true,
                    ),
                  )
                : ImageGeneric.network(
                    url: url,
                    options: options,
                    hasDropShadow: true,
                  )
            : hasHero
                ? Hero(
                    tag: url,
                    child: ImageGeneric.asset(
                      url: url,
                      options: options,
                    ),
                  )
                : ImageGeneric.asset(
                    url: url,
                    options: options,
                  ),
      ),
    );
  }
}
