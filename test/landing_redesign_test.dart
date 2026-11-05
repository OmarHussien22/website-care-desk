import 'package:coursaty/src/core/routers/app_routes.dart';
import 'package:coursaty/src/landing/core/animations/fade_in_on_scroll.dart';
import 'package:coursaty/src/landing/core/i18n/landing_translations.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/presentation/controllers/nav_bar_controller.dart';
import 'package:coursaty/src/landing/presentation/sections/features/features_section.dart';
import 'package:coursaty/src/landing/presentation/sections/hero/hero_section.dart';
import 'package:coursaty/src/landing/presentation/sections/services/services_section.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/nav_bar.dart';
import 'package:coursaty/src/landing/presentation/widgets/organisms/nav_bar_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class _Translations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': landingEnUS,
    'ar_AE': landingArAE,
  };
}

Future<void> _mount(WidgetTester tester, Size size, Locale locale) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  Get.testMode = true;
  Get.put(LandingScrollController());
  Get.put(NavBarController());
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => GetMaterialApp(
        locale: locale,
        translations: _Translations(),
        getPages: [
          GetPage(
            name: AppRoutes.landingMenu,
            page: () => const NavBarDrawer(),
          ),
          GetPage(
            name: AppRoutes.register,
            page: () => const Scaffold(body: SizedBox(key: Key('signup'))),
          ),
        ],
        home: MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: const Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      HeroSection(),
                      ServicesSection(),
                      FeaturesSection(),
                    ],
                  ),
                ),
                Positioned(top: 0, left: 0, right: 0, child: LandingNavBar()),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  setUp(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );
  tearDown(() async {
    Get.reset();
    VisibilityDetectorController.instance.updateInterval = const Duration(
      milliseconds: 500,
    );
  });

  for (final locale in const [Locale('en', 'US'), Locale('ar', 'AE')]) {
    for (final width in [320.0, 600.0, 1024.0, 1440.0]) {
      testWidgets('Redesign fits $width in ${locale.languageCode}', (
        tester,
      ) async {
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final originalHandler = FlutterError.onError;
        FlutterError.onError = (details) {
          FlutterError.dumpErrorToConsole(details);
          originalHandler?.call(details);
        };
        await _mount(tester, Size(width, 1000), locale);
        final exception = tester.takeException();
        FlutterError.onError = originalHandler;
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        expect(exception, isNull);
      });
    }
  }

  testWidgets('Mobile menu opens and registration uses the named route', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await _mount(tester, const Size(375, 900), const Locale('en', 'US'));
    await tester.tap(find.byTooltip(landingEnUS['nav.menu.open']!));
    await tester.pumpAndSettle();
    expect(find.byType(NavBarDrawer), findsOneWidget);
    await tester.tap(find.text(landingEnUS['nav.cta.demo']!).last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('signup')), findsOneWidget);
    expect(find.byType(NavBarDrawer), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('Reduced motion renders reveal content immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: FadeInOnScroll(child: SizedBox(key: Key('revealed'))),
        ),
      ),
    );
    expect(find.byKey(const Key('revealed')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(FadeInOnScroll),
        matching: find.byType(FadeTransition),
      ),
      findsNothing,
    );
  });
}
