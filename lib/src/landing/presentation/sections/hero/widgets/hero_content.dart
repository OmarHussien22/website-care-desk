import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/widgets/hero_cta_row.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Left text column of the hero section (eyebrow, headline, subheadline, CTAs, trust line).
class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final isMobile = size == ScreenSize.mobile;
    final isCentered = isMobile;

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _EyebrowChip(),
        const SizedBox(height: 20),

        _Headline(centered: isCentered),
        const SizedBox(height: 20),

        CustomText(
          'hero.subheadline'.tr,
          role: TextRole.bodyLG,
          color: Colors.white.withValues(alpha: 0.88),
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 36),

        if (isMobile)
          SizedBox(width: double.infinity, child: const HeroCtaRow())
        else
          const HeroCtaRow(),
        const SizedBox(height: 32),

        _TrustChip(centered: isCentered),
      ],
    );
  }
}

class _EyebrowChip extends StatelessWidget {
  const _EyebrowChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LandingColors.success,
              boxShadow: [
                BoxShadow(
                  color: LandingColors.success.withValues(alpha: 0.6),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          CustomText(
            'hero.eyebrow'.tr,
            scaleFont: false,
            fontSize: 13,
            fontWeight: FW.semiBold,
            color: Colors.white,
            fontFamily: 'Montserrat',
            letterSpacing: 0.5,
          ),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.centered});
  final bool centered;

  /// Responsive font size — must shrink on mobile to keep above-the-fold guarantee.
  double _fontSizeFor(ScreenSize size) {
    switch (size) {
      case ScreenSize.mobile:
        return 30;
      case ScreenSize.tablet:
        return 38;
      case ScreenSize.laptop:
        return 44;
      case ScreenSize.desktop:
        return 50;
      case ScreenSize.ultraWide:
        return 56;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);
    final whole = 'hero.headline'.tr;
    final emph = 'hero.headline.emph'.tr;
    final emphIndex =
        emph.isNotEmpty ? whole.toLowerCase().indexOf(emph.toLowerCase()) : -1;

    final baseStyle = TextStyle(
      fontSize: _fontSizeFor(size),
      fontWeight: FontWeight.w800,
      color: Colors.white,
      height: 1.15,
      fontFamily: 'Montserrat',
      letterSpacing: -0.4,
    );

    if (emphIndex < 0) {
      return Text(
        whole,
        style: baseStyle,
        textAlign: centered ? TextAlign.center : TextAlign.start,
      );
    }

    final before = whole.substring(0, emphIndex);
    final mid = whole.substring(emphIndex, emphIndex + emph.length);
    final after = whole.substring(emphIndex + emph.length);

    // Emphasized phrase uses brand success (emerald) — contrasts with the
    // sky/cyan hero gradient instead of fading into it.
    final emphStyle = baseStyle.copyWith(color: LandingColors.success);

    return RichText(
      textAlign: centered ? TextAlign.center : TextAlign.start,
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: before),
          TextSpan(text: mid, style: emphStyle),
          TextSpan(text: after),
        ],
      ),
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({required this.centered});
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            centered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          _AvatarStack(),
          const SizedBox(width: 12),
          Flexible(
            child: CustomText(
              'hero.trust'.tr,
              scaleFont: false,
              fontSize: 13,
              fontWeight: FW.medium,
              color: Colors.white.withValues(alpha: 0.92),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xFFFDE68A),
      Color(0xFFA7F3D0),
      Color(0xFFBFDBFE),
    ];
    return SizedBox(
      width: 56,
      height: 22,
      child: Stack(
        children: [
          for (int i = 0; i < colors.length; i++)
            Positioned(
              left: i * 16.0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors[i],
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
