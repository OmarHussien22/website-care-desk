import 'package:coursaty/src/landing/core/animations/fade_in_on_scroll.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/presentation/sections/footer/footer_section.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/hero_section.dart';
import 'package:coursaty/src/landing/presentation/sections/features/features_section.dart';
import 'package:coursaty/src/landing/presentation/sections/marketing/marketing_sections.dart';
import 'package:coursaty/src/landing/presentation/sections/pricing/pricing_section.dart';
import 'package:coursaty/src/landing/presentation/sections/services/services_section.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LandingScrollController>();

    return Scaffold(
      backgroundColor: LandingColors.surfaceMuted,
      body: Stack(
        children: [
          // ── Scrollable content ────────────────────────────────────────────
          CustomScrollView(
            controller: ctrl.scrollController,
            slivers: [
              // § 0 — Hero
              const SliverToBoxAdapter(child: HeroSection()),

              // Verified trust and platform foundations.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const TrustStripSection()),
              ),

              // § 2 — Services (Phase 3)
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const ServicesSection()),
              ),

              // Product screenshots / representative dashboard tour.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const ProductTourSection()),
              ),

              // Supported capabilities.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const FeaturesSection()),
              ),

              // Onboarding flow.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const HowItWorksSection()),
              ),

              // Doctors, medical centers, and receptionists.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const AudiencesSection()),
              ),

              // Responsive and upcoming native mobile experience.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const MobileAppSection()),
              ),

              // Backend-driven catalog.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const PricingSection()),
              ),

              // Product FAQ.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const FaqSection()),
              ),

              // Demo request form, safely idle without an endpoint.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const ContactSection()),
              ),

              // Consistent registration / login CTA.
              SliverToBoxAdapter(
                child: FadeInOnScroll(child: const FinalCtaSection()),
              ),

              // § 12 — Footer
              const SliverToBoxAdapter(child: FooterSection()),
            ],
          ),

          // ── Sticky NavBar overlay ─────────────────────────────────────────
          const Positioned(top: 0, left: 0, right: 0, child: LandingNavBar()),
        ],
      ),
    );
  }
}
