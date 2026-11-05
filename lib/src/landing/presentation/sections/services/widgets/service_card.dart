import '../../../../../core/services/utils/extensions/screen_spaces_extension.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/theme/landing_colors.dart';
import '../../../../core/typography/text_role.dart';
import '../../../../data/landing_metrics.dart';
import '../../../../../shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({
    super.key,
    required this.item,
    this.featured = false,
    this.index = 0,
  });
  final ServiceItem item;
  final bool featured;
  final int index;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    final gap = AppSpacing.md.resolve(context);
    final foreground = widget.featured
        ? LandingColors.onBrand
        : LandingColors.textPrimary;
    final muted = widget.featured
        ? LandingColors.onBrand.withValues(alpha: 0.75)
        : LandingColors.textSecondary;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: reducedMotion
            ? Duration.zero
            : const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(gap),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.featured
                  ? LandingColors.accentHover
                  : LandingColors.surfaceElevated,
              widget.featured
                  ? LandingColors.accent
                  : _hovered
                  ? LandingColors.accent.withValues(alpha: 0.06)
                  : LandingColors.surfaceMuted,
            ],
          ),
          borderRadius: BorderRadius.circular(gap),
          border: Border.all(
            color: _hovered
                ? LandingColors.accent.withValues(alpha: 0.32)
                : LandingColors.borderSubtle,
          ),
          boxShadow: [
            BoxShadow(
              color: LandingColors.accent.withValues(
                alpha: _hovered ? 0.09 : 0.025,
              ),
              blurRadius: AppSpacing.lg.resolve(context),
              offset: Offset(0, AppSpacing.xs.resolve(context)),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm.resolve(context)),
                  decoration: BoxDecoration(
                    color: widget.featured
                        ? LandingColors.onBrand.withValues(alpha: 0.12)
                        : LandingColors.heroHighlight.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.sm.resolve(context),
                    ),
                  ),
                  child: Icon(
                    widget.item.icon,
                    size: 24.toRad().clamp(22, 28),
                    color: widget.featured
                        ? LandingColors.heroHighlight
                        : LandingColors.accent,
                  ),
                ),
                const Spacer(),
                CustomText(
                  '0${widget.index + 1}',
                  role: TextRole.caption,
                  color: muted,
                ),
              ],
            ),
            SizedBox(height: gap),
            CustomText(
              widget.item.titleKey.tr,
              role: TextRole.headingMD,
              color: foreground,
            ),
            SizedBox(height: AppSpacing.sm.resolve(context)),
            CustomText(
              widget.item.descKey.tr,
              role: TextRole.bodyMD,
              color: muted,
            ),
          ],
        ),
      ),
    );
  }
}
