import 'package:coursaty/src/core/app/meddesk_config.dart';
import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/navigation/meddesk_actions.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/landing/data/landing_content.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/anchored_section.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/responsive_grid.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/product_screenshot.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/section_header.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrustStripSection extends StatelessWidget {
  const TrustStripSection({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        Icons.admin_panel_settings_rounded,
        'trust.secure.title',
        'trust.secure.desc',
      ),
      (
        Icons.domain_verification_rounded,
        'trust.tenant.title',
        'trust.tenant.desc',
      ),
      (Icons.translate_rounded, 'trust.language.title', 'trust.language.desc'),
      (Icons.trending_up_rounded, 'trust.scale.title', 'trust.scale.desc'),
    ];
    return AnchoredSection(
      sectionId: 'trust',
      background: LandingColors.surfaceMuted,
      verticalPadding: const Responsive(
        mobile: 34.0,
        tablet: 42.0,
        laptop: 48.0,
      ),
      child: ResponsiveGrid(
        columns: const Responsive<int>(mobile: 1, tablet: 2, laptop: 4),
        mainAxisSpacing: 14.0,
        crossAxisSpacing: 14.0,
        children: [
          for (final item in items)
            _TrustItem(icon: item.$1, titleKey: item.$2, descKey: item.$3),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({
    required this.icon,
    required this.titleKey,
    required this.descKey,
  });
  final IconData icon;
  final String titleKey;
  final String descKey;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 42.0,
        height: 42.0,
        decoration: BoxDecoration(
          color: LandingColors.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(icon, color: LandingColors.accent, size: 21.0),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              titleKey.tr,
              scaleFont: false,
              fontSize: 13.0,
              fontWeight: FW.bold,
              color: LandingColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
            const SizedBox(height: 5.0),
            CustomText(
              descKey.tr,
              scaleFont: false,
              fontSize: 11.5,
              textHeight: 1.45,
              color: LandingColors.textSecondary,
              fontFamily: 'Montserrat',
            ),
          ],
        ),
      ),
    ],
  );
}

class ProductTourSection extends StatefulWidget {
  const ProductTourSection({super.key});

  @override
  State<ProductTourSection> createState() => _ProductTourSectionState();
}

class _ProductTourSectionState extends State<ProductTourSection> {
  ProductScreen selected = ProductScreen.dashboard;

  String _label(ProductScreen value) => switch (value) {
    ProductScreen.dashboard => 'product.dashboard',
    ProductScreen.patients => 'product.patients',
    ProductScreen.appointments => 'product.appointments',
    ProductScreen.billing => 'product.billing',
  };

  String _caption(ProductScreen value) => switch (value) {
    ProductScreen.dashboard => 'product.caption.dashboard',
    ProductScreen.patients => 'product.caption.patients',
    ProductScreen.appointments => 'product.caption.appointments',
    ProductScreen.billing => 'product.caption.billing',
  };

  @override
  Widget build(BuildContext context) => AnchoredSection(
    sectionId: 'product',
    background: LandingColors.surfaceMuted,
    child: Column(
      children: [
        const SectionHeader(
          eyebrowKey: 'product.eyebrow',
          titleKey: 'product.title',
          subtitleKey: 'product.subtitle',
        ),
        const SizedBox(height: 34.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            for (final screen in ProductScreen.values)
              ChoiceChip(
                selected: selected == screen,
                onSelected: (_) => setState(() => selected = screen),
                selectedColor: LandingColors.accent,
                backgroundColor: LandingColors.surfaceElevated,
                side: BorderSide(
                  color: selected == screen
                      ? LandingColors.accent
                      : LandingColors.borderSubtle,
                ),
                label: CustomText(
                  _label(screen).tr,
                  scaleFont: false,
                  fontSize: 13.0,
                  fontWeight: FW.semiBold,
                  color: selected == screen
                      ? Colors.white
                      : LandingColors.textSecondary,
                  fontFamily: 'Montserrat',
                ),
              ),
          ],
        ),
        const SizedBox(height: 28.0),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          child: ProductScreenshot(
            key: ValueKey(selected),
            screen: selected,
            altTextKey: _label(selected),
          ),
        ),
        const SizedBox(height: 24.0),
        CustomText(
          _caption(selected).tr,
          role: TextRole.bodyMD,
          color: LandingColors.textSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) => AnchoredSection(
    sectionId: 'how-it-works',
    background: LandingColors.surfaceElevated,
    child: Column(
      children: [
        const SectionHeader(
          eyebrowKey: 'how.eyebrow',
          titleKey: 'how.title',
          subtitleKey: 'how.subtitle',
        ),
        const SizedBox(height: 48.0),
        ResponsiveGrid(
          columns: const Responsive<int>(mobile: 1, tablet: 2, laptop: 4),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            for (int index = 0; index < LandingContent.steps.length; index++)
              _StepCard(step: LandingContent.steps[index], index: index + 1),
          ],
        ),
      ],
    ),
  );
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step, required this.index});
  final HowStep step;
  final int index;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: LandingColors.surfaceMuted,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: LandingColors.borderSubtle),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: LandingColors.accent,
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: Icon(step.icon, color: Colors.white, size: 21.0),
            ),
            const Spacer(),
            CustomText(
              index.toString().padLeft(2, '0'),
              scaleFont: false,
              fontSize: 12.0,
              fontWeight: FW.bold,
              color: LandingColors.secondary,
              fontFamily: 'Montserrat',
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        CustomText(
          step.titleKey.tr,
          role: TextRole.headingSM,
          fontWeight: FW.bold,
          color: LandingColors.textPrimary,
        ),
        const SizedBox(height: 9.0),
        CustomText(
          step.descKey.tr,
          role: TextRole.bodySM,
          color: LandingColors.textSecondary,
        ),
      ],
    ),
  );
}

class AudiencesSection extends StatelessWidget {
  const AudiencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const audiences = [
      (
        Icons.medical_services_rounded,
        'audiences.doctors.title',
        'audiences.doctors.desc',
        [
          'audiences.doctors.b1',
          'audiences.doctors.b2',
          'audiences.doctors.b3',
        ],
      ),
      (
        Icons.local_hospital_rounded,
        'audiences.centers.title',
        'audiences.centers.desc',
        [
          'audiences.centers.b1',
          'audiences.centers.b2',
          'audiences.centers.b3',
        ],
      ),
      (
        Icons.support_agent_rounded,
        'audiences.reception.title',
        'audiences.reception.desc',
        [
          'audiences.reception.b1',
          'audiences.reception.b2',
          'audiences.reception.b3',
        ],
      ),
    ];
    return AnchoredSection(
      sectionId: 'audiences',
      background: LandingColors.surfaceMuted,
      child: Column(
        children: [
          const SectionHeader(
            eyebrowKey: 'audiences.eyebrow',
            titleKey: 'audiences.title',
            subtitleKey: 'audiences.subtitle',
          ),
          const SizedBox(height: 48.0),
          ResponsiveGrid(
            columns: const Responsive<int>(mobile: 1, tablet: 1, laptop: 3),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: [
              for (final audience in audiences)
                _AudienceCard(
                  icon: audience.$1,
                  titleKey: audience.$2,
                  descKey: audience.$3,
                  benefits: audience.$4,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AudienceCard extends StatelessWidget {
  const _AudienceCard({
    required this.icon,
    required this.titleKey,
    required this.descKey,
    required this.benefits,
  });
  final IconData icon;
  final String titleKey;
  final String descKey;
  final List<String> benefits;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(26.0),
    decoration: BoxDecoration(
      color: LandingColors.surfaceElevated,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: LandingColors.borderSubtle),
      boxShadow: [
        BoxShadow(
          color: LandingColors.accent.withValues(alpha: 0.05),
          blurRadius: 24.0,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: LandingColors.accent.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Icon(icon, color: LandingColors.accent, size: 25.0),
        ),
        const SizedBox(height: 22.0),
        CustomText(
          titleKey.tr,
          role: TextRole.headingMD,
          fontWeight: FW.bold,
          color: LandingColors.textPrimary,
        ),
        const SizedBox(height: 9.0),
        CustomText(
          descKey.tr,
          role: TextRole.bodyMD,
          color: LandingColors.textSecondary,
        ),
        const SizedBox(height: 22.0),
        for (final benefit in benefits)
          Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: LandingColors.success,
                  size: 18.0,
                ),
                const SizedBox(width: 9.0),
                Expanded(
                  child: CustomText(
                    benefit.tr,
                    role: TextRole.bodySM,
                    color: LandingColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

class MobileAppSection extends StatelessWidget {
  const MobileAppSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = ScreenSizeX.of(context).isLaptopOrLarger;
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: EyebrowPill(labelKey: 'mobile.eyebrow'),
        ),
        const SizedBox(height: 18.0),
        CustomText(
          'mobile.title'.tr,
          role: TextRole.displayLG,
          fontWeight: FW.bold,
          color: LandingColors.textPrimary,
        ),
        const SizedBox(height: 16.0),
        CustomText(
          'mobile.subtitle'.tr,
          role: TextRole.bodyLG,
          color: LandingColors.textSecondary,
        ),
        const SizedBox(height: 22.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: LandingColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(99.0),
          ),
          child: CustomText(
            'mobile.badge'.tr,
            scaleFont: false,
            fontSize: 12.0,
            color: LandingColors.accent,
            fontWeight: FW.semiBold,
          ),
        ),
        const SizedBox(height: 24.0),
        for (final key in const [
          'mobile.item1',
          'mobile.item2',
          'mobile.item3',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.check_rounded,
                  color: LandingColors.success,
                  size: 19.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: CustomText(
                    key.tr,
                    role: TextRole.bodyMD,
                    color: LandingColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    const mockup = ProductScreenshot(
      frameType: ProductFrameType.mobile,
      altTextKey: 'mobile.title',
    );
    return AnchoredSection(
      sectionId: 'mobile',
      background: LandingColors.surfaceElevated,
      child: wide
          ? Row(
              children: [
                Expanded(flex: 6, child: copy),
                const SizedBox(width: 72.0),
                const Expanded(flex: 4, child: Center(child: mockup)),
              ],
            )
          : Column(
              children: [
                copy,
                const SizedBox(height: 42.0),
                const Center(child: mockup),
              ],
            ),
    );
  }
}

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) => AnchoredSection(
    sectionId: 'faq',
    background: LandingColors.surfaceMuted,
    child: Column(
      children: [
        const SectionHeader(
          eyebrowKey: 'faq.eyebrow',
          titleKey: 'faq.title',
          subtitleKey: 'faq.subtitle',
        ),
        const SizedBox(height: 40.0),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820.0),
          child: Column(
            children: [
              for (int index = 1; index <= 6; index++)
                _FaqTile(questionKey: 'faq.q$index', answerKey: 'faq.a$index'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.questionKey, required this.answerKey});
  final String questionKey;
  final String answerKey;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: LandingColors.borderSubtle),
    ),
    child: Material(
      color: LandingColors.surfaceElevated,
      borderRadius: BorderRadius.circular(14.0),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        iconColor: LandingColors.accent,
        collapsedIconColor: LandingColors.secondary,
        title: CustomText(
          questionKey.tr,
          role: TextRole.headingSM,
          fontWeight: FW.semiBold,
          color: LandingColors.textPrimary,
        ),
        childrenPadding: const EdgeInsetsDirectional.fromSTEB(
          18.0,
          0.0,
          18.0,
          18.0,
        ),
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: CustomText(
              answerKey.tr,
              role: TextRole.bodyMD,
              color: LandingColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showUnavailable = false;

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'register.required'.tr : null;

  @override
  Widget build(BuildContext context) {
    final fields = [
      'contact.name',
      'contact.country',
      'contact.phone',
      'contact.email',
      'contact.clinic',
    ];
    return AnchoredSection(
      sectionId: 'contact',
      background: LandingColors.surfaceElevated,
      child: Column(
        children: [
          const SectionHeader(
            eyebrowKey: 'contact.eyebrow',
            titleKey: 'contact.title',
            subtitleKey: 'contact.subtitle',
          ),
          const SizedBox(height: 38.0),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final twoColumns = constraints.maxWidth >= 680.0;
                      final fieldWidgets = [
                        for (final key in fields)
                          _MarketingField(labelKey: key, validator: _required),
                      ];
                      if (!twoColumns)
                        return Column(
                          children: [
                            for (final field in fieldWidgets)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: field,
                              ),
                          ],
                        );
                      return Wrap(
                        spacing: 14.0,
                        runSpacing: 14.0,
                        children: [
                          for (final field in fieldWidgets)
                            SizedBox(
                              width: (constraints.maxWidth - 14.0) / 2,
                              child: field,
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14.0),
                  _MarketingField(
                    labelKey: 'contact.message',
                    validator: _required,
                    maxLines: 4,
                  ),
                  if (showUnavailable) ...[
                    const SizedBox(height: 14.0),
                    _Notice(messageKey: 'contact.unavailable'),
                  ],
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState?.validate() != true) return;
                        setState(() => showUnavailable = true);
                      },
                      icon: const Icon(Icons.arrow_outward_rounded),
                      label: CustomText(
                        'contact.submit'.tr,
                        role: TextRole.button,
                        color: Colors.white,
                        fontWeight: FW.semiBold,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LandingColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 17.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketingField extends StatelessWidget {
  const _MarketingField({
    required this.labelKey,
    required this.validator,
    this.maxLines = 1,
  });
  final String labelKey;
  final FormFieldValidator<String> validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextFormField(
    maxLines: maxLines,
    validator: validator,
    style: TextStyle(
      color: LandingColors.textPrimary,
      fontFamily: 'Montserrat',
      fontSize: 14.0,
    ),
    decoration: InputDecoration(
      labelText: labelKey.tr,
      labelStyle: TextStyle(
        color: LandingColors.textSecondary,
        fontFamily: 'Montserrat',
        fontSize: 13.0,
      ),
      filled: true,
      fillColor: LandingColors.surfaceMuted,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: LandingColors.borderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: LandingColors.borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: LandingColors.accent, width: 1.5),
      ),
    ),
  );
}

class _Notice extends StatelessWidget {
  const _Notice({required this.messageKey});
  final String messageKey;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: LandingColors.secondary.withValues(alpha: 0.09),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: LandingColors.secondary.withValues(alpha: 0.22),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: LandingColors.secondary,
          size: 20.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: CustomText(
            messageKey.tr,
            role: TextRole.bodySM,
            color: LandingColors.textPrimary,
          ),
        ),
      ],
    ),
  );
}

class FinalCtaSection extends StatelessWidget {
  const FinalCtaSection({super.key});

  @override
  Widget build(BuildContext context) => AnchoredSection(
    sectionId: 'cta',
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [LandingColors.accent, MedDeskConfig.accentColor],
      ),
    ),
    verticalPadding: const Responsive(mobile: 56.0, tablet: 64.0, laptop: 72.0),
    child: Column(
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: const Icon(
            Icons.medical_services_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20.0),
        CustomText(
          'cta.eyebrow'.tr,
          role: TextRole.caption,
          color: Colors.white70,
          fontWeight: FW.bold,
        ),
        const SizedBox(height: 12.0),
        CustomText(
          'cta.title'.tr,
          role: TextRole.displayLG,
          color: Colors.white,
          fontWeight: FW.bold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14.0),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680.0),
          child: CustomText(
            'cta.subtitle'.tr,
            role: TextRole.bodyLG,
            color: Colors.white.withValues(alpha: 0.82),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 28.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            ElevatedButton(
              onPressed: MedDeskActions.openRegistration,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: LandingColors.accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0,
              ),
              child: CustomText(
                'cta.primary'.tr,
                role: TextRole.button,
                color: LandingColors.accent,
                fontWeight: FW.bold,
              ),
            ),
            OutlinedButton(
              onPressed: MedDeskActions.openClinicLogin,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: CustomText(
                'cta.secondary'.tr,
                role: TextRole.button,
                color: Colors.white,
                fontWeight: FW.semiBold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
