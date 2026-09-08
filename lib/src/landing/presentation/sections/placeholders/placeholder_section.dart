import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/section_wrapper.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shared placeholder widget for Phase 3+ sections.
/// Self-registers its anchor key with [LandingScrollController].
/// Reads as a stylized "coming soon" panel rather than a broken section.
class PlaceholderSection extends StatefulWidget {
  const PlaceholderSection({
    super.key,
    required this.sectionId,
    this.background,
  });

  final String sectionId;
  final Color? background;

  @override
  State<PlaceholderSection> createState() => _PlaceholderSectionState();
}

class _PlaceholderSectionState extends State<PlaceholderSection> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<LandingScrollController>().registerSection(
          widget.sectionId,
          _key,
        );
      }
    });
  }

  @override
  void dispose() {
    Get.find<LandingScrollController>().unregisterSection(widget.sectionId);
    super.dispose();
  }

  /// Section indices match §6 of phase_3.md (stats=1, services=2 are built).
  static const _sectionIndex = <String, int>{
    'logos': 3,
    'features': 4,
    'how-it-works': 5,
    'for-clinicians': 6,
    'for-patients': 7,
    'pricing': 8,
    'testimonials': 9,
    'faq': 10,
    'cta': 11,
  };

  static const _sectionTitle = <String, String>{
    'logos': 'Trusted partners',
    'features': 'Features',
    'how-it-works': 'How it works',
    'for-clinicians': 'For clinicians',
    'for-patients': 'For patients',
    'pricing': 'Pricing',
    'testimonials': 'Loved by teams',
    'faq': 'Questions',
    'cta': 'Get started',
  };

  String _title(String id) =>
      _sectionTitle[id] ??
      id
          .split('-')
          .map((p) => p.isEmpty ? p : '${p[0].toUpperCase()}${p.substring(1)}')
          .join(' ');

  String _index(String id) =>
      (_sectionIndex[id] ?? 0).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final bg = widget.background ?? LandingColors.surfaceElevated;

    return SectionWrapper(
      sectionKey: _key,
      background: bg,
      verticalPaddingOverride: const Responsive(
        mobile: 96.0,
        tablet: 120.0,
        laptop: 140.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NumberBadge(index: _index(widget.sectionId)),
              const SizedBox(height: 20),
              CustomText(
                _title(widget.sectionId),
                role: TextRole.displayLG,
                fontWeight: FW.bold,
                color: LandingColors.textPrimary,
                fontFamily: 'Montserrat',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              _ComingSoonChip(),
              const SizedBox(height: 28),
              const _DecorativeDivider(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  const _NumberBadge({required this.index});
  final String index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LandingColors.accentGradientStart.withValues(alpha: 0.10),
            LandingColors.accentGradientEnd.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: LandingColors.accentGradientStart.withValues(alpha: 0.20),
        ),
      ),
      alignment: Alignment.center,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (rect) => LinearGradient(
          colors: [
            LandingColors.accentGradientStart,
            LandingColors.accentGradientEnd,
          ],
        ).createShader(rect),
        child: CustomText(
          index,
          scaleFont: false,
          fontSize: 20,
          fontWeight: FW.bold,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ComingSoonChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: LandingColors.accentGradientStart.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LandingColors.accentGradientStart,
            ),
          ),
          const SizedBox(width: 8),
          CustomText(
            'section.coming_soon'.tr,
            scaleFont: false,
            fontSize: 12,
            fontWeight: FW.semiBold,
            fontFamily: 'Montserrat',
            color: LandingColors.accent,
            letterSpacing: 0.6,
          ),
        ],
      ),
    );
  }
}

class _DecorativeDivider extends StatelessWidget {
  const _DecorativeDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              LandingColors.borderSubtle,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
