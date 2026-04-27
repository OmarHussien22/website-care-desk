mixin ApiNames {
  static const baseUrl = "https://api.carepro.techlabeg.com/api/";

  /// ----------------------------- app status ------------------------------
  final uRLFetchAppStatus = "${baseUrl}fetch_app_status";

  /// ----------------------------- Auth ------------------------------
  final uRLLogin = "${baseUrl}login";
  final uRLRegister = "${baseUrl}register";
  final uRLVerifyPhone = "${baseUrl}verify_phone";
  final uRLCheckPhone = "${baseUrl}check_phone";
  final uRLForgetPassword = "${baseUrl}forgot_password";
  final uRLResetPassword = "${baseUrl}reset_password";
  final uRLChangePassword = "${baseUrl}change_password";
  final uRLCheckCode = "${baseUrl}check_code";
  final uRLLogout = '${baseUrl}logout';
  final uRLDeleteAccount = '${baseUrl}delete_account';
  final uRLCheckApproved = "${baseUrl}check_approved";
  final urlAddNationalAddress = "${baseUrl}create_or_update_national_address";
  final urlAddOtherAddresses = "${baseUrl}update_or_create_another_address";
  final uRLFetchNationalities = '${baseUrl}fetch_locations_without_children';
  final uRLFetchCountries = '${baseUrl}fetch_locations_without_children';
  final uRLFetchTermsAndConditions = '${baseUrl}fetch_terms_and_conditions';
  final uRlUpdateProfile = '${baseUrl}update_profile';
  final uRlCompleteData = '${baseUrl}complete_data';
  final uRlChangePhone = '${baseUrl}change_phone';
  final uRlDeleteAnotherAddress = '${baseUrl}delete_another_address';
}
