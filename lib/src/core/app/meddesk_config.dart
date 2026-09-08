import 'package:flutter/material.dart';

/// Single source of truth for MedDesk branding, API, and deployment URLs.
///
/// Public catalog/onboarding paths point to the website contracts exposed by
/// the companion Laravel project. Every value remains overridable at build
/// time for staging and production deployments.
abstract final class MedDeskConfig {
  static const String applicationName = 'MedDesk';
  static const Color primaryColor = Color(0xFF0F3A52);
  static const Color primaryHoverColor = Color(0xFF0A2C3F);
  static const Color secondaryColor = Color(0xFF68848F);
  static const Color accentColor = Color(0xFF2F7D99);

  static const List<String> supportedLanguages = ['ar', 'en'];
  static const String defaultLanguage = 'ar';

  static const String apiBaseUrl = String.fromEnvironment(
    'MEDDESK_API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api/v1/',
  );
  static const String dashboardBaseUrl = String.fromEnvironment(
    'MEDDESK_DASHBOARD_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const String publicPlansPath = String.fromEnvironment(
    'MEDDESK_PUBLIC_PLANS_PATH',
    defaultValue: '/website/plans',
  );
  static const String publicSpecialtiesPath = String.fromEnvironment(
    'MEDDESK_PUBLIC_SPECIALTIES_PATH',
    defaultValue: '/website/specialties',
  );
  static const String publicRegistrationPath = String.fromEnvironment(
    'MEDDESK_PUBLIC_REGISTRATION_PATH',
    defaultValue: '/website/register',
  );
  static String get clinicLoginUrl => '$dashboardBaseUrl/clinic/login';
  static String get clinicDashboardUrl => '$dashboardBaseUrl/clinic';

  static String apiUrl(String path) {
    final normalizedBase = apiBaseUrl.endsWith('/')
        ? apiBaseUrl.substring(0, apiBaseUrl.length - 1)
        : apiBaseUrl;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return '$normalizedBase$normalizedPath';
  }
}
