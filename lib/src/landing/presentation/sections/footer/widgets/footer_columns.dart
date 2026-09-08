import 'dart:developer';

import 'package:coursaty/src/landing/core/breakpoints/screen_size.dart';
import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

typedef _FooterItem = ({String labelKey, String? sectionId, String? url});

const List<_FooterItem> _productLinks = [
  (labelKey: 'footer.link.features', sectionId: 'features', url: null),
  (labelKey: 'footer.link.how_it_works', sectionId: 'how-it-works', url: null),
  (labelKey: 'footer.link.pricing', sectionId: 'pricing', url: null),
];

const List<_FooterItem> _companyLinks = [
  (labelKey: 'footer.link.about', sectionId: 'product', url: null),
  (labelKey: 'footer.link.contact', sectionId: 'contact', url: null),
  (labelKey: 'footer.link.careers', sectionId: 'audiences', url: null),
];

const List<_FooterItem> _resourceLinks = [
  (labelKey: 'footer.link.help', sectionId: null, url: LandingBrand.helpUrl),
  (
    labelKey: 'footer.link.privacy',
    sectionId: null,
    url: LandingBrand.privacyUrl,
  ),
  (labelKey: 'footer.link.terms', sectionId: null, url: LandingBrand.termsUrl),
];

/// Responsive footer link columns.
/// Desktop/laptop: 3 side-by-side columns. Tablet: 2 × 2. Mobile: accordion.
class FooterColumns extends StatelessWidget {
  const FooterColumns({super.key});

  @override
  Widget build(BuildContext context) {
    final size = ScreenSizeX.of(context);

    if (size == ScreenSize.mobile) {
      return _MobileAccordion();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _Column(
            headingKey: 'footer.column.product',
            items: _productLinks,
          ),
        ),
        Expanded(
          child: _Column(
            headingKey: 'footer.column.company',
            items: _companyLinks,
          ),
        ),
        Expanded(
          child: _Column(
            headingKey: 'footer.column.resources',
            items: _resourceLinks,
          ),
        ),
      ],
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.headingKey, required this.items});
  final String headingKey;
  final List<_FooterItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          headingKey.tr.toUpperCase(),
          scaleFont: false,
          fontSize: 12,
          fontWeight: FW.bold,
          color: LandingColors.textPrimary,
          fontFamily: 'Montserrat',
          letterSpacing: 1.2,
        ),
        const SizedBox(height: 20),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _FooterLink(item: item),
          ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.item});
  final _FooterItem item;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

void _navigateFooterItem(_FooterItem item) {
  if (item.sectionId != null) {
    Get.find<LandingScrollController>().scrollTo(item.sectionId!);
  } else if (item.url != null && item.url != '#') {
    final uri = Uri.parse(item.url!);
    canLaunchUrl(uri).then((ok) {
      if (ok) launchUrl(uri, mode: LaunchMode.externalApplication);
    });
  } else {
    log('footer link: placeholder destination', name: 'Footer');
  }
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _navigateFooterItem(widget.item),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: 14,
            color: _hovered
                ? LandingColors.accent
                : LandingColors.textSecondary,
            fontFamily: 'Montserrat',
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
          ),
          child: CustomText(
            widget.item.labelKey.tr,
            scaleFont: false,
            fontSize: 14,
            color: _hovered
                ? LandingColors.accent
                : LandingColors.textSecondary,
            fontWeight: _hovered ? FW.semiBold : FW.regular,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}

class _MobileAccordion extends StatefulWidget {
  @override
  State<_MobileAccordion> createState() => _MobileAccordionState();
}

class _MobileAccordionState extends State<_MobileAccordion> {
  int? _open;

  static const List<({String headingKey, List<_FooterItem> items})> _sections =
      [
        (headingKey: 'footer.column.product', items: _productLinks),
        (headingKey: 'footer.column.company', items: _companyLinks),
        (headingKey: 'footer.column.resources', items: _resourceLinks),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _sections.length; i++)
          Material(
            color: Colors.transparent,
            child: ExpansionTile(
              title: CustomText(
                _sections[i].headingKey.tr,
                scaleFont: false,
                fontSize: 15,
                fontWeight: FW.semiBold,
                color: LandingColors.textPrimary,
              ),
              initiallyExpanded: _open == i,
              onExpansionChanged: (open) =>
                  setState(() => _open = open ? i : null),
              children: [
                for (final item in _sections[i].items)
                  ListTile(
                    dense: true,
                    title: CustomText(
                      item.labelKey.tr,
                      scaleFont: false,
                      color: LandingColors.textSecondary,
                    ),
                    onTap: () => _navigateFooterItem(item),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
