import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:flutter/material.dart';

/// The shared MedDesk lockup built from the official application mark.
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.height = 34.0,
    this.inverse = false,
    this.showWordmark = true,
  });

  final double height;
  final bool inverse;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: 'MedDesk',
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(height * 0.22),
            child: Image.asset(
              LandingBrand.appLogoMark,
              width: height,
              height: height,
              fit: BoxFit.cover,
              excludeFromSemantics: true,
              filterQuality: FilterQuality.high,
            ),
          ),
          if (showWordmark) ...[
            SizedBox(width: height * 0.25),
            Text(
              'MedDesk',
              style: TextStyle(
                color: inverse ? Colors.white : LandingColors.accent,
                fontFamily: 'Montserrat',
                fontSize: height * 0.58,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: -0.45,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
