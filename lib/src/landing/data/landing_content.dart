import 'package:flutter/material.dart';

/// Static catalogs for the Phase 4 content sections
/// (Logos · Features · How-it-works · For-clinicians · For-patients).
///
/// Parallel to [landing_metrics.dart]. Copy is product-owned; the `.tr` keys
/// here are stable and resolved against `landing_translations.dart`.
/// `IconData` in `data/` follows the accepted static-UI-catalog exception.

/// A single feature row in the Features section.
class FeatureItem {
  const FeatureItem({
    required this.icon,
    required this.titleKey,
    required this.descKey,
  });

  final IconData icon;
  final String titleKey;
  final String descKey;
}

/// A single onboarding step in the How-it-works timeline.
class HowStep {
  const HowStep({
    required this.icon,
    required this.titleKey,
    required this.descKey,
  });

  final IconData icon;
  final String titleKey;
  final String descKey;
}

/// A single benefit bullet in an [AudienceContent] block.
class AudienceBenefit {
  const AudienceBenefit({required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;
}

/// Content variant for the reusable Audience section (clinicians / patients).
class AudienceContent {
  const AudienceContent({
    required this.sectionId,
    required this.eyebrowKey,
    required this.titleKey,
    required this.subtitleKey,
    required this.ctaKey,
    required this.benefits,
  });

  final String sectionId;
  final String eyebrowKey;
  final String titleKey;
  final String subtitleKey;
  final String ctaKey;
  final List<AudienceBenefit> benefits;

  static const clinicians = AudienceContent(
    sectionId: 'for-clinicians',
    eyebrowKey: 'for_clinicians.eyebrow',
    titleKey: 'for_clinicians.title',
    subtitleKey: 'for_clinicians.subtitle',
    ctaKey: 'for_clinicians.cta',
    benefits: [
      AudienceBenefit(
        icon: Icons.dashboard_customize_rounded,
        labelKey: 'for_clinicians.benefit1',
      ),
      AudienceBenefit(
        icon: Icons.notifications_active_rounded,
        labelKey: 'for_clinicians.benefit2',
      ),
      AudienceBenefit(
        icon: Icons.insights_rounded,
        labelKey: 'for_clinicians.benefit3',
      ),
    ],
  );

  static const patients = AudienceContent(
    sectionId: 'for-patients',
    eyebrowKey: 'for_patients.eyebrow',
    titleKey: 'for_patients.title',
    subtitleKey: 'for_patients.subtitle',
    ctaKey: 'for_patients.cta',
    benefits: [
      AudienceBenefit(
        icon: Icons.event_available_rounded,
        labelKey: 'for_patients.benefit1',
      ),
      AudienceBenefit(
        icon: Icons.alarm_on_rounded,
        labelKey: 'for_patients.benefit2',
      ),
      AudienceBenefit(
        icon: Icons.local_offer_rounded,
        labelKey: 'for_patients.benefit3',
      ),
    ],
  );
}

/// A placeholder partner mark in the Logos strip (swap to real assets later).
class LogoMark {
  const LogoMark({required this.labelKey, required this.icon});

  final String labelKey;
  final IconData icon;
}

/// Catalog of Phase 4 static content.
abstract final class LandingContent {
  static const List<FeatureItem> features = [
    FeatureItem(
      icon: Icons.event_available_rounded,
      titleKey: 'features.booking.title',
      descKey: 'features.booking.desc',
    ),
    FeatureItem(
      icon: Icons.notifications_active_rounded,
      titleKey: 'features.notifications.title',
      descKey: 'features.notifications.desc',
    ),
    FeatureItem(
      icon: Icons.assessment_rounded,
      titleKey: 'features.reports.title',
      descKey: 'features.reports.desc',
    ),
    FeatureItem(
      icon: Icons.inventory_2_rounded,
      titleKey: 'features.products.title',
      descKey: 'features.products.desc',
    ),
    FeatureItem(
      icon: Icons.badge_rounded,
      titleKey: 'features.doctors.title',
      descKey: 'features.doctors.desc',
    ),
    FeatureItem(
      icon: Icons.schedule_rounded,
      titleKey: 'features.scheduling.title',
      descKey: 'features.scheduling.desc',
    ),
    FeatureItem(
      icon: Icons.people_alt_rounded,
      titleKey: 'features.patients.title',
      descKey: 'features.patients.desc',
    ),
    FeatureItem(
      icon: Icons.medical_information_rounded,
      titleKey: 'features.records.title',
      descKey: 'features.records.desc',
    ),
    FeatureItem(
      icon: Icons.support_agent_rounded,
      titleKey: 'features.support.title',
      descKey: 'features.support.desc',
    ),
    FeatureItem(
      icon: Icons.workspace_premium_rounded,
      titleKey: 'features.subscription.title',
      descKey: 'features.subscription.desc',
    ),
    FeatureItem(
      icon: Icons.domain_rounded,
      titleKey: 'features.tenant.title',
      descKey: 'features.tenant.desc',
    ),
    FeatureItem(
      icon: Icons.tune_rounded,
      titleKey: 'features.settings.title',
      descKey: 'features.settings.desc',
    ),
  ];

  static const List<HowStep> steps = [
    HowStep(
      icon: Icons.person_add_alt_1_rounded,
      titleKey: 'how.register.title',
      descKey: 'how.register.desc',
    ),
    HowStep(
      icon: Icons.add_business_rounded,
      titleKey: 'how.center.title',
      descKey: 'how.center.desc',
    ),
    HowStep(
      icon: Icons.groups_rounded,
      titleKey: 'how.doctors.title',
      descKey: 'how.doctors.desc',
    ),
    HowStep(
      icon: Icons.event_available_rounded,
      titleKey: 'how.appointments.title',
      descKey: 'how.appointments.desc',
    ),
  ];

  static const List<LogoMark> logos = [
    LogoMark(labelKey: 'logos.mark1', icon: Icons.health_and_safety_rounded),
    LogoMark(labelKey: 'logos.mark2', icon: Icons.local_hospital_rounded),
    LogoMark(labelKey: 'logos.mark3', icon: Icons.medical_information_rounded),
    LogoMark(labelKey: 'logos.mark4', icon: Icons.healing_rounded),
    LogoMark(labelKey: 'logos.mark5', icon: Icons.vaccines_rounded),
    LogoMark(labelKey: 'logos.mark6', icon: Icons.monitor_heart_rounded),
  ];
}
