class AppRoutes {
  AppRoutes._private();

  /// --------------------- welcome -------------------------------
  static const splash = "/splash";
  static const onboarding = "/onboarding";

  /// --------------------- auth -------------------------------
  static const mainAuth = "/main_auth";
  static const login = "/login";
  static const register = "/register";
  static const forgotPassword = "/forgot_password";
  static const verifyCode = "/verify_code";
  static const resetPassword = "/reset_password";
  static const setEducationInfo = "/set_education_info";

  /// --------------------- profile -------------------------------
  static const profile = "/profile";
  static const language = "/language";
  static const selectCountry = "/select_country";
  static const changePassword = "/change_password";
  static const aboutApp = "/about_app";
  static const privacyPolicy = "/privacy_policy";
  static const termsConditions = "/terms_conditions";
  static const faqs = "/faqs";
  static const support = "/support";
  static const editProfile = "/edit_profile";
  static const parentInfo = "/parent_info";
  static const inviteCode = "/invite_code";

  /// --------------------- home -------------------------------
  static const base = "/base";

  /// --------------------- landing -------------------------------
  /// Web: '/' — served as the root. Native: '/landing' (splash takes '/splash').
  static const landing = "/landing";
  static const landingRoot = "/";
}
