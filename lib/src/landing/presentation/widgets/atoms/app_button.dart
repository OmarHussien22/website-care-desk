import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, ghost }

/// Landing page button skeleton. Styling will be fleshed out in Phase 2.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    // TODO(phase2): Apply AppTextStyles.of(context, TextRole.button) and full variant styling.
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
