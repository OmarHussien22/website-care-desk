import '../app/meddesk_config.dart';

mixin ApiNames {
  static const baseUrl = MedDeskConfig.apiBaseUrl;

  /// ----------------------------- app status ------------------------------
  final uRLFetchAppStatus = MedDeskConfig.apiUrl('fetch_app_status');

  /// ----------------------------- Auth ------------------------------
  final uRLLogin = MedDeskConfig.apiUrl('login');
  final uRLRegister = MedDeskConfig.apiUrl('register');
  final uRLCheckVerificationCode = MedDeskConfig.apiUrl(
    'check_verification_code',
  );
  final uRLResendVerificationCode = MedDeskConfig.apiUrl(
    'resend_verification_code',
  );
  final uRLForgetPassword = MedDeskConfig.apiUrl('forgot_password');
  final uRLResetPassword = MedDeskConfig.apiUrl('reset_password');
  final uRLChangePassword = MedDeskConfig.apiUrl('change_password');
  final uRLLogout = MedDeskConfig.apiUrl('logout');
  final uRLDeleteAccount = MedDeskConfig.apiUrl('delete_account');
  final uRLSetUserEducationInfo = MedDeskConfig.apiUrl(
    'set_user_education_info',
  );
  final uRLFetchEducationTypes = MedDeskConfig.apiUrl('fetch_education_types');
  final uRLSetParentData = MedDeskConfig.apiUrl('set_parent_data');
  final uRLCheckInvitationCode = MedDeskConfig.apiUrl('check_invitation_code');

  /// Public website endpoints exposed by the companion Laravel backend.
  final uRLPublicPlans = MedDeskConfig.publicPlansPath.isEmpty
      ? ''
      : MedDeskConfig.apiUrl(MedDeskConfig.publicPlansPath);
  final uRLPublicSpecialties = MedDeskConfig.publicSpecialtiesPath.isEmpty
      ? ''
      : MedDeskConfig.apiUrl(MedDeskConfig.publicSpecialtiesPath);
  final uRLPublicRegistration = MedDeskConfig.publicRegistrationPath.isEmpty
      ? ''
      : MedDeskConfig.apiUrl(MedDeskConfig.publicRegistrationPath);
}
