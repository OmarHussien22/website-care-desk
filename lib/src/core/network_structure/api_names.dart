mixin ApiNames {
  static const baseUrl = "https://api.carepro.techlabeg.com/api/";

  /// ----------------------------- app status ------------------------------
  final uRLFetchAppStatus = "${baseUrl}fetch_app_status";

  /// ----------------------------- Auth ------------------------------
  final uRLLogin = "${baseUrl}login";
  final uRLRegister = "${baseUrl}register";
  final uRLCheckVerificationCode = '${baseUrl}check_verification_code';
  final uRLResendVerificationCode = '${baseUrl}resend_verification_code';
  final uRLForgetPassword = "${baseUrl}forgot_password";
  final uRLResetPassword = "${baseUrl}reset_password";
  final uRLChangePassword = "${baseUrl}change_password";
  final uRLLogout = '${baseUrl}logout';
  final uRLDeleteAccount = '${baseUrl}delete_account';
  final uRLSetUserEducationInfo = '${baseUrl}set_user_education_info';
  final uRLFetchEducationTypes = '${baseUrl}fetch_education_types';
  final uRLSetParentData = '${baseUrl}set_parent_data';
  final uRLCheckInvitationCode = '${baseUrl}check_invitation_code';

}

