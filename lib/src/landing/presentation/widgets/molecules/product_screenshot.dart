import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProductFrameType { browser, desktop, mobile }

enum ProductScreen { dashboard, patients, appointments, billing }

/// Replaceable product-preview component. It supports desktop/browser/mobile
/// framing today and can accept a real image asset later without changing the
/// section layouts that consume it.
class ProductScreenshot extends StatelessWidget {
  const ProductScreenshot({
    super.key,
    this.frameType = ProductFrameType.browser,
    this.screen = ProductScreen.dashboard,
    this.assetPath,
    this.altTextKey = 'product.dashboard',
  });

  final ProductFrameType frameType;
  final ProductScreen screen;
  final String? assetPath;
  final String altTextKey;

  @override
  Widget build(BuildContext context) {
    final mobile = frameType == ProductFrameType.mobile;
    final compact = mobile || ScreenSizeX.of(context) == ScreenSize.mobile;
    final radius = mobile ? 30.0 : 20.0;
    final body = assetPath == null
        ? _DashboardPreview(screen: screen, compact: compact)
        : Image.asset(
            assetPath!,
            fit: BoxFit.cover,
            semanticLabel: altTextKey.tr,
            filterQuality: FilterQuality.medium,
          );

    return Semantics(
      image: true,
      label: altTextKey.tr,
      child: RepaintBoundary(
        child: Container(
          constraints: BoxConstraints(maxWidth: mobile ? 310.0 : 920.0),
          padding: EdgeInsets.all(mobile ? 9.0 : 1.0),
          decoration: BoxDecoration(
            color: mobile
                ? LandingColors.textPrimary
                : LandingColors.borderSubtle,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: LandingColors.accent.withValues(alpha: 0.16),
                blurRadius: mobile ? 32.0 : 44.0,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius - 2.0),
            child: ColoredBox(
              color: LandingColors.surfaceElevated,
              child: Column(
                children: [
                  if (frameType == ProductFrameType.browser)
                    const _BrowserBar(),
                  if (frameType == ProductFrameType.desktop)
                    const _DesktopBar(),
                  if (frameType == ProductFrameType.mobile) const _MobileBar(),
                  AspectRatio(
                    aspectRatio: mobile
                        ? 0.58
                        : compact
                        ? 0.72
                        : 1.62,
                    child: body,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrowserBar extends StatelessWidget {
  const _BrowserBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.0,
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F8),
        border: Border(bottom: BorderSide(color: LandingColors.borderSubtle)),
      ),
      child: Row(
        children: [
          for (final color in const [
            Color(0xFFFF7A71),
            Color(0xFFFFC85A),
            Color(0xFF57C785),
          ]) ...[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6.0),
          ],
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              height: 22.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: LandingColors.borderSubtle),
              ),
              alignment: Alignment.center,
              child: CustomText(
                'app.meddesk',
                scaleFont: false,
                fontSize: 9.0,
                color: LandingColors.textSecondary,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopBar extends StatelessWidget {
  const _DesktopBar();

  @override
  Widget build(BuildContext context) => Container(
    height: 24.0,
    color: LandingColors.textPrimary,
    alignment: Alignment.center,
    child: Container(
      width: 42.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(99.0),
      ),
    ),
  );
}

class _MobileBar extends StatelessWidget {
  const _MobileBar();

  @override
  Widget build(BuildContext context) => Container(
    height: 25.0,
    color: LandingColors.textPrimary,
    alignment: Alignment.center,
    child: Container(
      width: 58.0,
      height: 5.0,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(99.0),
      ),
    ),
  );
}

class _DashboardPreview extends StatelessWidget {
  const _DashboardPreview({required this.screen, required this.compact});

  final ProductScreen screen;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) return const _MobilePreview();
    return Row(
      children: [
        const _Sidebar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PreviewHeading(screen: screen),
                const SizedBox(height: 14.0),
                Expanded(child: _ScreenBody(screen: screen)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) => Container(
    width: 112.0,
    padding: const EdgeInsets.all(13.0),
    color: LandingColors.accent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 15.0,
                color: LandingColors.accent,
              ),
            ),
            const SizedBox(width: 7.0),
            const Flexible(
              child: CustomText(
                'MedDesk',
                scaleFont: false,
                fontSize: 9.0,
                color: Colors.white,
                fontWeight: FW.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        for (int index = 0; index < 6; index++) ...[
          Container(
            height: 25.0,
            margin: const EdgeInsets.only(bottom: 7.0),
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            decoration: BoxDecoration(
              color: index == 0
                  ? Colors.white.withValues(alpha: 0.16)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Row(
              children: [
                Icon(
                  [
                    Icons.grid_view_rounded,
                    Icons.event_rounded,
                    Icons.people_rounded,
                    Icons.medical_services_rounded,
                    Icons.receipt_long_rounded,
                    Icons.bar_chart_rounded,
                  ][index],
                  size: 11.0,
                  color: Colors.white70,
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  child: Container(
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.38),
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

class _PreviewHeading extends StatelessWidget {
  const _PreviewHeading({required this.screen});
  final ProductScreen screen;

  @override
  Widget build(BuildContext context) {
    final title = switch (screen) {
      ProductScreen.dashboard => 'product.dashboard',
      ProductScreen.patients => 'product.patients',
      ProductScreen.appointments => 'product.appointments',
      ProductScreen.billing => 'product.billing',
    };
    return Row(
      children: [
        Expanded(
          child: CustomText(
            title.tr,
            scaleFont: false,
            fontSize: 15.0,
            fontWeight: FW.bold,
            color: LandingColors.textPrimary,
            fontFamily: 'Montserrat',
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: LandingColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CustomText(
            'mock.today'.tr,
            scaleFont: false,
            fontSize: 8.0,
            color: LandingColors.accent,
            fontWeight: FW.semiBold,
          ),
        ),
      ],
    );
  }
}

class _ScreenBody extends StatelessWidget {
  const _ScreenBody({required this.screen});
  final ProductScreen screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _MetricCard(
              icon: Icons.event_available_rounded,
              label: 'mock.appointments',
              tint: LandingColors.accent,
            ),
            const SizedBox(width: 10.0),
            _MetricCard(
              icon: Icons.people_alt_rounded,
              label: 'mock.patients',
              tint: LandingColors.secondary,
            ),
            const SizedBox(width: 10.0),
            _MetricCard(
              icon: Icons.payments_rounded,
              label: 'mock.revenue',
              tint: LandingColors.success,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(13.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: LandingColors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'mock.schedule'.tr,
                  scaleFont: false,
                  fontSize: 10.0,
                  fontWeight: FW.bold,
                  color: LandingColors.textPrimary,
                ),
                const SizedBox(height: 10.0),
                for (int index = 0; index < 3; index++) ...[
                  Expanded(child: _TableRow(index: index)),
                  if (index < 2)
                    Divider(height: 1.0, color: LandingColors.borderSubtle),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.tint,
  });
  final IconData icon;
  final String label;
  final Color tint;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(color: LandingColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 27.0,
            height: 27.0,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, size: 14.0, color: tint),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label.tr,
                  scaleFont: false,
                  fontSize: 7.0,
                  color: LandingColors.textSecondary,
                ),
                const SizedBox(height: 3.0),
                CustomText(
                  ['24', '1,248', '32.4K'][label == 'mock.appointments'
                      ? 0
                      : label == 'mock.patients'
                      ? 1
                      : 2],
                  scaleFont: false,
                  fontSize: 11.0,
                  fontWeight: FW.bold,
                  color: LandingColors.textPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TableRow extends StatelessWidget {
  const _TableRow({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: LandingColors.accent.withValues(alpha: 0.09),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person_rounded,
          size: 13.0,
          color: LandingColors.accent,
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: LandingColors.borderSubtle,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      const SizedBox(width: 18.0),
      Container(
        width: 54.0,
        height: 17.0,
        decoration: BoxDecoration(
          color: (index == 1 ? LandingColors.secondary : LandingColors.success)
              .withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(99.0),
        ),
        alignment: Alignment.center,
        child: CustomText(
          (index == 1 ? 'mock.waiting' : 'mock.confirmed').tr,
          scaleFont: false,
          fontSize: 6.5,
          color: index == 1 ? LandingColors.secondary : LandingColors.success,
          fontWeight: FW.semiBold,
        ),
      ),
    ],
  );
}

class _MobilePreview extends StatelessWidget {
  const _MobilePreview();

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFFF5F8F9),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: LandingColors.accent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.notifications_none_rounded,
              color: LandingColors.textPrimary,
              size: 21.0,
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        CustomText(
          'mock.schedule'.tr,
          scaleFont: false,
          fontSize: 17.0,
          fontWeight: FW.bold,
          color: LandingColors.textPrimary,
          fontFamily: 'Montserrat',
        ),
        const SizedBox(height: 14.0),
        for (int index = 0; index < 3; index++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.0),
              border: Border.all(color: LandingColors.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: BoxDecoration(
                    color: LandingColors.accent.withValues(alpha: 0.09),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 18.0,
                    color: LandingColors.accent,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 6.0,
                        width: 75.0,
                        decoration: BoxDecoration(
                          color: LandingColors.textPrimary.withValues(
                            alpha: 0.18,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Container(
                        height: 5.0,
                        width: 52.0,
                        decoration: BoxDecoration(
                          color: LandingColors.borderSubtle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(
                  ['09:00', '10:30', '12:00'][index],
                  scaleFont: false,
                  fontSize: 9.0,
                  color: LandingColors.accent,
                  fontWeight: FW.bold,
                ),
              ],
            ),
          ),
          const SizedBox(height: 9.0),
        ],
      ],
    ),
  );
}
