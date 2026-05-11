
import 'dart:ui';

abstract class BaseRouteArgs {}

/// -------------------------- Auth --------------------------
class VerifyCodeArgs extends BaseRouteArgs {
  final String phone;
  final bool isRegister;
  final String? title;
  final bool viewPhone;

  VerifyCodeArgs({
    this.title,
    this.viewPhone = false,
    required this.phone,
    this.isRegister = false,
  });
}


class ResetPasswordArgs extends BaseRouteArgs {
  final String phone;

  ResetPasswordArgs({
    required this.phone,
  });
}

