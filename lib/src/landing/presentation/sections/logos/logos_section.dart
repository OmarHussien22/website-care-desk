import 'package:coursaty/src/landing/core/breakpoints/responsive.dart';
import 'package:coursaty/src/landing/core/spacing/app_spacing.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_clients.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/anchored_section.dart';
import 'package:coursaty/src/landing/presentation/widgets/layout/responsive_grid.dart';
import 'package:coursaty/src/landing/presentation/widgets/molecules/section_header.dart';
import 'package:flutter/material.dart';

import 'widgets/logo_tile.dart';

/// Only confirmed client identities are shown as social proof.
class LogosSection extends StatelessWidget {
  const LogosSection({super.key, this.clients = LandingClients.items});
  final List<LandingClient> clients;

  @override
  Widget build(BuildContext context) {
    if (clients.isEmpty) return const SizedBox.shrink();

    return AnchoredSection(
      sectionId: 'clients',
      background: LandingColors.surfaceElevated,
      verticalPadding: AppSpacing.xl,
      child: Column(
        children: [
          const SectionHeader(
            eyebrowKey: 'clients.eyebrow',
            titleKey: 'clients.title',
            subtitleKey: 'clients.subtitle',
          ),
          SizedBox(height: AppSpacing.lg.resolve(context)),
          ResponsiveGrid(
            columns: Responsive<int>(
              mobile: 1,
              tablet: clients.length.clamp(1, 2),
              laptop: clients.length.clamp(1, 3),
              desktop: clients.length.clamp(1, 4),
            ),
            mainAxisSpacing: AppSpacing.md.resolve(context),
            crossAxisSpacing: AppSpacing.md.resolve(context),
            children: [for (final client in clients) LogoTile(client: client)],
          ),
        ],
      ),
    );
  }
}
