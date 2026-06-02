import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/data/landing_metrics.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A single service: gradient icon badge, title, and description.
/// Lifts with a deeper shadow on hover (pointer devices); static on touch.
class ServiceCard extends StatefulWidget {
  const ServiceCard({super.key, required this.item});

  final ServiceItem item;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.item.titleKey.tr,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: LandingColors.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: LandingColors.borderSubtle),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.10 : 0.06),
                blurRadius: _hovered ? 24 : 3,
                offset: Offset(0, _hovered ? 8 : 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _IconBadge(icon: widget.item.icon),
              const SizedBox(height: 20),
              CustomText(
                widget.item.titleKey.tr,
                role: TextRole.headingMD,
                fontWeight: FW.bold,
                fontFamily: 'Montserrat',
                color: LandingColors.textPrimary,
              ),
              const SizedBox(height: 10),
              CustomText(
                widget.item.descKey.tr,
                role: TextRole.bodyMD,
                color: LandingColors.textSecondary,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LandingColors.accentGradientStart.withValues(alpha: 0.12),
            LandingColors.accentGradientEnd.withValues(alpha: 0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
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
        child: Icon(icon, size: 26, color: Colors.white),
      ),
    );
  }
}
