import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A single NavBar anchor link with active-state pill + animated hover underline.
class NavLink extends StatefulWidget {
  const NavLink({
    super.key,
    required this.labelKey,
    required this.sectionId,
    this.onTap,
    this.textColor,
  });

  final String labelKey;
  final String sectionId;
  final VoidCallback? onTap;
  final Color? textColor;

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LandingScrollController>();

    return Obx(() {
      final isActive = ctrl.currentSectionId == widget.sectionId;

      final Color resolvedTextColor;
      if (widget.textColor != null) {
        resolvedTextColor = isActive ? Colors.white : widget.textColor!;
      } else {
        resolvedTextColor = isActive
            ? LandingColors.accentGradientStart
            : LandingColors.textSecondary;
      }

      return Semantics(
        button: true,
        label: widget.labelKey.tr,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap ?? () => ctrl.scrollTo(widget.sectionId),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: isActive
                  ? BoxDecoration(
                      color: widget.textColor != null
                          ? Colors.white.withValues(alpha: 0.18)
                          : LandingColors.accentGradientStart.withValues(
                              alpha: 0.12,
                            ),
                      borderRadius: BorderRadius.circular(999),
                    )
                  : null,
              // Stack lets the hover underline overlap without adding height.
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  CustomText(
                    widget.labelKey.tr,
                    scaleFont: false,
                    fontSize: 14,
                    fontWeight: isActive ? FW.semiBold : FW.medium,
                    fontFamily: 'Montserrat',
                    color: resolvedTextColor,
                  ),
                  Positioned(
                    bottom: -4,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      height: 2,
                      width: (_hovered && !isActive) ? 18 : 0,
                      decoration: BoxDecoration(
                        color: widget.textColor != null
                            ? Colors.white.withValues(alpha: 0.9)
                            : LandingColors.accentGradientStart,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
