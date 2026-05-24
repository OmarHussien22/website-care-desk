import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Landing icon wrapper — supports Iconsax IconData and SVG asset paths.
class AppIcon extends StatelessWidget {
  const AppIcon.icon({
    super.key,
    required IconData this.icon,
    this.size = 24,
    this.color,
  }) : svgAsset = null;

  const AppIcon.svg({
    super.key,
    required String this.svgAsset,
    this.size = 24,
    this.color,
  }) : icon = null;

  final IconData? icon;
  final String? svgAsset;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset!,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }
    return Icon(icon, size: size, color: color);
  }
}
