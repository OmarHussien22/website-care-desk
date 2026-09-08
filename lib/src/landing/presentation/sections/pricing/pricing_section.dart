import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/features/clinic_onboarding/domain/entities/plan_entity.dart';
import 'package:coursaty/src/features/clinic_onboarding/presentation/controllers/pricing_controller.dart';
import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/navigation/meddesk_actions.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/anchored_section.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/responsive_grid.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/section_header.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) => AnchoredSection(
    sectionId: 'pricing',
    background: LandingColors.surfaceElevated,
    child: Column(
      children: [
        const SectionHeader(
          eyebrowKey: 'pricing.eyebrow',
          titleKey: 'pricing.title',
          subtitleKey: 'pricing.subtitle',
        ),
        const SizedBox(height: 18.0),
        const _LiveCatalogBadge(),
        const SizedBox(height: 34.0),
        GetBuilder<PricingController>(
          init: PricingController(),
          builder: (controller) {
            if (!controller.endpointAvailable) {
              return const _CatalogState(
                icon: Icons.cloud_off_rounded,
                messageKey: 'pricing.unavailable',
              );
            }
            if (controller.isLoading) return const _LoadingState();
            if (controller.state is DataFailed<List<PlanEntity>>) {
              return _CatalogState(
                icon: Icons.cloud_sync_rounded,
                messageKey: 'pricing.load_error',
                onRetry: controller.fetchPlans,
              );
            }
            final plans = controller.state.data ?? const <PlanEntity>[];
            if (plans.isEmpty) {
              return const _CatalogState(
                icon: Icons.layers_clear_rounded,
                messageKey: 'pricing.empty',
              );
            }
            return ResponsiveGrid(
              columns: const Responsive<int>(
                mobile: 1,
                tablet: 2,
                laptop: 3,
                desktop: 4,
                ultraWide: 4,
              ),
              mainAxisSpacing: 18.0,
              crossAxisSpacing: 18.0,
              children: [for (final plan in plans) PricingCard(plan: plan)],
            );
          },
        ),
      ],
    ),
  );
}

class _LiveCatalogBadge extends StatelessWidget {
  const _LiveCatalogBadge();

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'pricing.live'.tr,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: LandingColors.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(99.0),
        border: Border.all(
          color: LandingColors.success.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(
              color: LandingColors.success,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: LandingColors.success.withValues(alpha: 0.35),
                  blurRadius: 7.0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          CustomText(
            'pricing.live'.tr,
            role: TextRole.caption,
            color: LandingColors.success,
            fontWeight: FW.bold,
          ),
        ],
      ),
    ),
  );
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(99.0),
        child: SizedBox(
          width: 180.0,
          child: LinearProgressIndicator(
            minHeight: 4.0,
            color: LandingColors.accent,
            backgroundColor: LandingColors.surfaceMuted,
          ),
        ),
      ),
      const SizedBox(height: 14.0),
      CustomText(
        'pricing.loading'.tr,
        role: TextRole.bodyMD,
        color: LandingColors.textSecondary,
      ),
    ],
  );
}

class _CatalogState extends StatelessWidget {
  const _CatalogState({
    required this.icon,
    required this.messageKey,
    this.onRetry,
  });

  final IconData icon;
  final String messageKey;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    constraints: const BoxConstraints(maxWidth: 720.0),
    padding: const EdgeInsets.all(30.0),
    decoration: BoxDecoration(
      color: LandingColors.surfaceMuted,
      borderRadius: BorderRadius.circular(22.0),
      border: Border.all(color: LandingColors.borderSubtle),
    ),
    child: Column(
      children: [
        Container(
          width: 52.0,
          height: 52.0,
          decoration: BoxDecoration(
            color: LandingColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Icon(icon, color: LandingColors.accent, size: 27.0),
        ),
        const SizedBox(height: 16.0),
        CustomText(
          messageKey.tr,
          role: TextRole.bodyMD,
          color: LandingColors.textSecondary,
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 18.0),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18.0),
            label: CustomText(
              'pricing.retry'.tr,
              role: TextRole.button,
              color: Colors.white,
              fontWeight: FW.bold,
            ),
            style: FilledButton.styleFrom(
              backgroundColor: LandingColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class PricingCard extends StatefulWidget {
  const PricingCard({super.key, required this.plan});

  final PlanEntity plan;

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;
    final language = Get.locale?.languageCode ?? 'ar';
    final highlighted = plan.type == 'trial' || plan.hasDiscount;
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -7.0 : 0, 0),
        padding: const EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          color: LandingColors.surfaceElevated,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: highlighted
                ? LandingColors.accent.withValues(alpha: 0.55)
                : LandingColors.borderSubtle,
            width: highlighted ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: LandingColors.accent.withValues(
                alpha: _hovered ? 0.14 : 0.07,
              ),
              blurRadius: _hovered ? 34.0 : 24.0,
              offset: Offset(0, _hovered ? 18.0 : 12.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PlanHeader(plan: plan, language: language),
            const SizedBox(height: 22.0),
            _PlanPrice(plan: plan),
            const SizedBox(height: 21.0),
            Divider(color: LandingColors.borderSubtle, height: 1.0),
            const SizedBox(height: 19.0),
            const _SectionLabel(labelKey: 'pricing.limits'),
            const SizedBox(height: 12.0),
            _LimitsPanel(limits: plan.limits),
            const SizedBox(height: 20.0),
            const _SectionLabel(labelKey: 'pricing.features'),
            const SizedBox(height: 12.0),
            for (final feature in plan.features.take(5))
              _FeatureRow(feature: feature),
            if (plan.features.isEmpty) const SizedBox(height: 8.0),
            const SizedBox(height: 18.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: MedDeskActions.openRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: LandingColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  elevation: 0,
                ),
                child: CustomText(
                  'pricing.start'.tr,
                  role: TextRole.button,
                  color: Colors.white,
                  fontWeight: FW.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanHeader extends StatelessWidget {
  const _PlanHeader({required this.plan, required this.language});

  final PlanEntity plan;
  final String language;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 44.0,
        height: 44.0,
        decoration: BoxDecoration(
          gradient: LandingColors.accentGradient,
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Icon(
          plan.type == 'trial'
              ? Icons.auto_awesome_rounded
              : Icons.bolt_rounded,
          color: Colors.white,
          size: 22.0,
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: CustomText(
            plan.localizedName(language),
            role: TextRole.headingSM,
            fontWeight: FW.bold,
            color: LandingColors.textPrimary,
            maxLines: 2,
          ),
        ),
      ),
      if (plan.hasDiscount) ...[
        const SizedBox(width: 8.0),
        _DiscountBadge(plan: plan),
      ],
    ],
  );
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.plan});

  final PlanEntity plan;

  @override
  Widget build(BuildContext context) {
    final value = plan.discountValue.toStringAsFixed(
      plan.discountValue % 1 == 0 ? 0 : 2,
    );
    final text = plan.discountType == 'percentage'
        ? 'pricing.discount_percentage'.trParams({'value': value})
        : 'pricing.discount_fixed'.trParams({
            'value': value,
            'currency': plan.currency,
          });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: LandingColors.success.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: CustomText(
        text,
        scaleFont: false,
        fontSize: 10.0,
        color: LandingColors.success,
        fontWeight: FW.bold,
      ),
    );
  }
}

class _PlanPrice extends StatelessWidget {
  const _PlanPrice({required this.plan});

  final PlanEntity plan;

  String _format(double value) => value.toStringAsFixed(value % 1 == 0 ? 0 : 2);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (plan.hasDiscount)
        CustomText(
          '${_format(plan.price)} ${plan.currency}',
          role: TextRole.bodySM,
          color: LandingColors.textSecondary,
          decoration: CustomTextDecoration.lineThrough,
        ),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 7.0,
        children: [
          CustomText(
            plan.finalPrice == 0 ? 'pricing.free'.tr : _format(plan.finalPrice),
            scaleFont: false,
            fontSize: plan.finalPrice == 0 ? 31.0 : 38.0,
            fontWeight: FW.bold,
            color: LandingColors.accent,
            fontFamily: plan.finalPrice == 0 ? null : 'Montserrat',
          ),
          if (plan.finalPrice != 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: CustomText(
                plan.currency,
                role: TextRole.bodySM,
                color: LandingColors.textSecondary,
                fontWeight: FW.semiBold,
              ),
            ),
        ],
      ),
      const SizedBox(height: 4.0),
      CustomText(
        'pricing.duration'.trParams({'days': plan.durationDays.toString()}),
        role: TextRole.bodySM,
        color: LandingColors.textSecondary,
      ),
    ],
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.labelKey});

  final String labelKey;

  @override
  Widget build(BuildContext context) => CustomText(
    labelKey.tr,
    role: TextRole.caption,
    color: LandingColors.textSecondary,
    fontWeight: FW.bold,
  );
}

class _LimitsPanel extends StatelessWidget {
  const _LimitsPanel({required this.limits});

  final Map<String, int?> limits;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(13.0),
    decoration: BoxDecoration(
      color: LandingColors.surfaceMuted,
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(color: LandingColors.borderSubtle),
    ),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 9.0,
      children: [
        for (final entry in limits.entries)
          _LimitChip(labelKey: 'pricing.${entry.key}', value: entry.value),
      ],
    ),
  );
}

class _LimitChip extends StatelessWidget {
  const _LimitChip({required this.labelKey, required this.value});

  final String labelKey;
  final int? value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: LandingColors.surfaceElevated,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_rounded, color: LandingColors.accent, size: 15.0),
        const SizedBox(width: 5.0),
        CustomText(
          '${labelKey.tr}: ',
          scaleFont: false,
          fontSize: 11.0,
          color: LandingColors.textSecondary,
        ),
        CustomText(
          value?.toString() ?? 'pricing.unlimited'.tr,
          scaleFont: false,
          fontSize: 11.0,
          color: LandingColors.textPrimary,
          fontWeight: FW.bold,
        ),
      ],
    ),
  );
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature});

  final PlanFeatureEntity feature;

  String get _label {
    final translationKey = 'pricing.feature.${feature.key}';
    final translated = translationKey.tr;
    return translated == translationKey ? feature.name : translated;
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: LandingColors.success.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            color: LandingColors.success,
            size: 14.0,
          ),
        ),
        const SizedBox(width: 9.0),
        Expanded(
          child: CustomText(
            _label,
            role: TextRole.bodySM,
            color: LandingColors.textPrimary,
          ),
        ),
      ],
    ),
  );
}
