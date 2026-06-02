import 'package:coursaty/src/landing/core/animations/fade_in_on_scroll.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/presentation/sections/footer/footer_section.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/hero_section.dart';
import 'package:coursaty/src/landing/presentation/sections/placeholders/placeholder_section.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LandingScrollController>();

    return Scaffold(
      backgroundColor: LandingColors.surfaceElevated,
      body: Stack(
        children: [
          // ── Scrollable content ────────────────────────────────────────────
          CustomScrollView(
            controller: ctrl.scrollController,
            slivers: [
              // § 0 — Hero
              const SliverToBoxAdapter(child: HeroSection()),

              // § 1 — Logos strip (Phase 3)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: PlaceholderSection(
                    sectionId: 'logos',
                    background: LandingColors.surfaceMuted,
                  ),
                ),
              ),

              // § 2 — Features (Phase 3)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: const PlaceholderSection(sectionId: 'features'),
                ),
              ),

              // § 3 — How it works (Phase 3)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: PlaceholderSection(
                    sectionId: 'how-it-works',
                    background: LandingColors.surfaceMuted,
                  ),
                ),
              ),

              // § 4 — For clinicians (Phase 3)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: const PlaceholderSection(sectionId: 'for-clinicians'),
                ),
              ),

              // § 5 — For patients (Phase 3)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: PlaceholderSection(
                    sectionId: 'for-patients',
                    background: LandingColors.surfaceMuted,
                  ),
                ),
              ),

              // § 6 — Pricing (Phase 4)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: const PlaceholderSection(sectionId: 'pricing'),
                ),
              ),

              // § 7 — Testimonials (Phase 4)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: PlaceholderSection(
                    sectionId: 'testimonials',
                    background: LandingColors.surfaceMuted,
                  ),
                ),
              ),

              // § 8 — FAQ (Phase 4)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: const PlaceholderSection(sectionId: 'faq'),
                ),
              ),

              // § 9 — CTA (Phase 4)
              SliverToBoxAdapter(
                child: FadeInOnScroll(
                  child: PlaceholderSection(
                    sectionId: 'cta',
                    background: LandingColors.surfaceMuted,
                  ),
                ),
              ),

              // § 10 — Footer
              const SliverToBoxAdapter(child: FooterSection()),
            ],
          ),

          // ── Sticky NavBar overlay ─────────────────────────────────────────
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LandingNavBar(),
          ),
        ],
      ),
    );
  }
}
