/// Public client identities supplied by the MedDesk team.
/// Add confirmed clients here; the section and navigation stay hidden when empty.
/// Asset paths can reference PNG, WebP, or SVG files bundled in pubspec.yaml.
abstract final class LandingClients {
  static const List<LandingClient> items = [];
}

class LandingClient {
  const LandingClient({
    required this.nameEn,
    required this.nameAr,
    this.logoAsset,
    this.descriptionEn,
    this.descriptionAr,
  });

  final String nameEn;
  final String nameAr;
  final String? logoAsset;
  final String? descriptionEn;
  final String? descriptionAr;
}
