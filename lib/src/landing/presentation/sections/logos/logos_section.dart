import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/data/landing_content.dart';
import 'package:coursaty/src/landing/presentation/sections/logos/widgets/logo_tile.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Slim social-proof band: a caption above a reflowing wall of partner marks.
/// Self-registers anchor id `logos` with [LandingScrollController].
class LogosSection extends StatefulWidget {
  const LogosSection({super.key});

  @override
  State<LogosSection> createState() => _LogosSectionState();
}

class _LogosSectionState extends State<LogosSection> {
  static const String _sectionId = 'logos';
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<LandingScrollController>().registerSection(_sectionId, _key);
      }
    });
  }

  @override
  void dispose() {
    Get.find<LandingScrollController>().unregisterSection(_sectionId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: _key,
      background: LandingColors.surfaceMuted,
      child: Column(
        children: [
          CustomText(
            'logos.caption'.tr,
            role: TextRole.bodyMD,
            fontWeight: FW.semiBold,
            color: LandingColors.textSecondary,
            textAlign: TextAlign.center,
            letterSpacing: 0.4,
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final mark in LandingContent.logos) LogoTile(mark: mark),
            ],
          ),
        ],
      ),
    );
  }
}
