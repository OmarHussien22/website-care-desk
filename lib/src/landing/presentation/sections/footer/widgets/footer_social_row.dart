import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/data/landing_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

/// Row of social media icon buttons in the footer.
/// Hover: subtle scale + accent tint + soft circular background.
class FooterSocialRow extends StatelessWidget {
  const FooterSocialRow({super.key});

  static const List<({String icon, String url, String label})> _socials = [
    (icon: LandingBrand.socialLinkedIn, url: LandingBrand.linkedInUrl, label: 'LinkedIn'),
    (icon: LandingBrand.socialX, url: LandingBrand.xUrl, label: 'X'),
    (icon: LandingBrand.socialYouTube, url: LandingBrand.youTubeUrl, label: 'YouTube'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final s in _socials)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _SocialButton(icon: s.icon, url: s.url, label: s.label),
          ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.url,
    required this.label,
  });

  final String icon;
  final String url;
  final String label;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  Future<void> _open() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor =
        _hovered ? LandingColors.accent : LandingColors.textSecondary;
    final bg = _hovered
        ? LandingColors.accentGradientStart.withValues(alpha: 0.10)
        : Colors.transparent;
    final border = _hovered
        ? LandingColors.accentGradientStart.withValues(alpha: 0.30)
        : LandingColors.borderSubtle;

    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: _open,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()..scale(_hovered ? 1.06 : 1.0),
            transformAlignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              border: Border.all(color: border, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                widget.icon,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
