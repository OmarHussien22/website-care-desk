import 'package:coursaty/src/landing/core/i18n/landing_translations.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/widgets/hero_cta_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class _LandingTestTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': landingEnUS};
}

/// Reproduces the hero CTA horizontal overflow at narrow tablet widths.
/// At tablet the hero is a two-column layout, so the CTA row only gets ~half
/// the viewport width. Two min-width buttons side by side exceed that, so they
/// must wrap to a second line instead of overflowing.
void main() {
  testWidgets('HeroCtaRow fits within a half-tablet-width column', (tester) async {
    // Mid tablet: hero left column ≈ 380px. Two CTA buttons side by side exceed
    // this, so a fixed Row overflows (the bug); a Wrap drops the second button
    // to a new line instead. Width is chosen so a single button fits even under
    // flutter_test's fallback font (Montserrat isn't loaded in tests, so glyphs
    // measure ~1.5× wider than in the real app — real tablets are safer still).
    const columnWidth = 380.0;
    tester.view.physicalSize = const Size(900, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, _) => GetMaterialApp(
          locale: const Locale('en', 'US'),
          translations: _LandingTestTranslations(),
          home: const Scaffold(
            body: Center(
              child: SizedBox(
                width: columnWidth,
                child: HeroCtaRow(),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull,
        reason: 'HeroCtaRow should not overflow at narrow tablet widths');
  });
}
