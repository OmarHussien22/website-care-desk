import 'package:flutter/material.dart';

/// Static catalogs for the Statistics and Services sections (Phase 3).
///
/// Values here are placeholders until product confirms real figures
/// (see phase_3.md §11 / §14 Q1). Icons use Material `Icons.*` to match the
/// landing house convention — `iconsax` is declared but unused in landing code.

/// A single headline metric in the Statistics band.
class StatItem {
  const StatItem({
    required this.icon,
    required this.target,
    required this.labelKey,
    this.suffix = '+',
  });

  final IconData icon;

  /// The number the counter animates up to (raw, un-formatted).
  final int target;

  /// `.tr` key for the caption beneath the number.
  final String labelKey;

  /// Appended after the formatted value (e.g. `250` → `250+`).
  final String suffix;
}

/// A single service card in the Services grid.
class ServiceItem {
  const ServiceItem({
    required this.icon,
    required this.titleKey,
    required this.descKey,
  });

  final IconData icon;
  final String titleKey;
  final String descKey;
}

/// Catalog of landing-page static content for Phase 3.
abstract final class LandingMetrics {
  static const List<StatItem> stats = [
    StatItem(
      icon: Icons.medical_services_rounded,
      target: 250,
      labelKey: 'stats.doctors',
    ),
    StatItem(
      icon: Icons.groups_rounded,
      target: 40000,
      labelKey: 'stats.patients',
    ),
    StatItem(
      icon: Icons.local_hospital_rounded,
      target: 120,
      labelKey: 'stats.centers',
    ),
    StatItem(
      icon: Icons.event_available_rounded,
      target: 1200000,
      labelKey: 'stats.appointments',
    ),
  ];

  static const List<ServiceItem> services = [
    ServiceItem(
      icon: Icons.medical_services_rounded,
      titleKey: 'services.doctor_mgmt.title',
      descKey: 'services.doctor_mgmt.desc',
    ),
    ServiceItem(
      icon: Icons.calendar_month_rounded,
      titleKey: 'services.appointments.title',
      descKey: 'services.appointments.desc',
    ),
    ServiceItem(
      icon: Icons.storefront_rounded,
      titleKey: 'services.marketplace.title',
      descKey: 'services.marketplace.desc',
    ),
    ServiceItem(
      icon: Icons.local_offer_rounded,
      titleKey: 'services.discounts.title',
      descKey: 'services.discounts.desc',
    ),
    ServiceItem(
      icon: Icons.insights_rounded,
      titleKey: 'services.analytics.title',
      descKey: 'services.analytics.desc',
    ),
    ServiceItem(
      icon: Icons.apartment_rounded,
      titleKey: 'services.multicenter.title',
      descKey: 'services.multicenter.desc',
    ),
  ];
}
