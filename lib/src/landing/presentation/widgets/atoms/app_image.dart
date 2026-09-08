import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Landing image wrapper — network (cached), local asset, or SVG.
class AppImage extends StatelessWidget {
  const AppImage.network({
    super.key,
    required String this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : assetPath = null,
       svgAsset = null;

  const AppImage.asset({
    super.key,
    required String this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : url = null,
       svgAsset = null;

  const AppImage.svg({
    super.key,
    required String this.svgAsset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  }) : url = null,
       assetPath = null;

  final String? url;
  final String? assetPath;
  final String? svgAsset;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset!,
        width: width,
        height: height,
        fit: fit,
      );
    }
    if (url != null) {
      return CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
      );
    }
    return Image.asset(assetPath!, width: width, height: height, fit: fit);
  }
}
