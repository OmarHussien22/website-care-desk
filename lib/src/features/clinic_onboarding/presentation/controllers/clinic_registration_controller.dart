import 'package:coursaty/src/core/app/meddesk_config.dart';
import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/features/clinic_onboarding/core/params/clinic_registration_params.dart';
import 'package:coursaty/src/features/clinic_onboarding/core/utils/phone_number_formatter.dart';
import 'package:coursaty/src/features/clinic_onboarding/domain/entities/specialty_entity.dart';
import 'package:coursaty/src/features/clinic_onboarding/domain/use_cases/fetch_specialties_use_case.dart';
import 'package:coursaty/src/features/clinic_onboarding/domain/use_cases/register_clinic_use_case.dart';
import 'package:coursaty/src/landing/core/navigation/meddesk_actions.dart';
import 'package:coursaty/src/super/controllers/resources/get/get_controller_interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicRegistrationController
    extends GetControllerInterface<ClinicRegistrationEntity> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;
  late final TextEditingController countryController;
  late final TextEditingController countryCodeController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController clinicNameController;

  DataState<List<SpecialtyEntity>> specialtiesState =
      DataInitial<List<SpecialtyEntity>>();
  SpecialtyEntity? selectedSpecialty;
  String clinicType = 'doctor';
  bool showPassword = false;
  bool integrationUnavailable = false;

  bool get registrationEndpointAvailable =>
      MedDeskConfig.publicRegistrationPath.isNotEmpty;
  bool get specialtiesEndpointAvailable =>
      MedDeskConfig.publicSpecialtiesPath.isNotEmpty;
  bool get isSubmitting => state is DataLoading<ClinicRegistrationEntity>;

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    countryController = TextEditingController();
    countryCodeController = TextEditingController(text: '+20');
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    clinicNameController = TextEditingController();
    if (specialtiesEndpointAvailable) fetchSpecialties();
  }

  Future<void> fetchSpecialties() async {
    if (!specialtiesEndpointAvailable) return;
    specialtiesState = const DataLoading<List<SpecialtyEntity>>();
    update();
    specialtiesState =
        await FetchSpecialtiesUseCase()() ??
        DataInitial<List<SpecialtyEntity>>();
    update();
  }

  void selectSpecialty(SpecialtyEntity? value) {
    selectedSpecialty = value;
    update();
  }

  void setClinicType(String value) {
    clinicType = value;
    update();
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  Future<void> submit() async {
    integrationUnavailable =
        !registrationEndpointAvailable || !specialtiesEndpointAvailable;
    if (integrationUnavailable) {
      update();
      return;
    }
    if (globalKey.currentState?.validate() != true || selectedSpecialty == null)
      return;

    emit(const DataLoading<ClinicRegistrationEntity>());
    final phone = PhoneNumberFormatter.toInternational(
      countryCode: countryCodeController.text,
      localNumber: phoneController.text,
    );
    state =
        await RegisterClinicUseCase()(
          params: ClinicRegistrationParams(
            ownerName: fullNameController.text.trim(),
            ownerPhone: phone,
            ownerPassword: passwordController.text,
            clinicName: clinicNameController.text.trim(),
            clinicType: clinicType,
            email: emailController.text.trim(),
            specialtyId: selectedSpecialty?.id ?? 0,
          ),
        ) ??
        DataInitial<ClinicRegistrationEntity>();
    update();
    if (state is DataSuccess<ClinicRegistrationEntity>) {
      await Future<void>.delayed(const Duration(milliseconds: 650));
      await MedDeskActions.openClinicLogin();
    }
  }

  String? requiredValidator(String? value) =>
      value == null || value.trim().isEmpty ? 'register.required'.tr : null;

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'register.required'.tr;
    if (!GetUtils.isEmail(value.trim())) return 'register.invalid_email'.tr;
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'register.required'.tr;
    if (!RegExp(r'^\d{7,15}$').hasMatch(value.trim()))
      return 'register.invalid_phone'.tr;
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'register.required'.tr;
    if (value.length < 8) return 'register.password_length'.tr;
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text)
      return 'register.password_mismatch'.tr;
    return passwordValidator(value);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    countryController.dispose();
    countryCodeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    clinicNameController.dispose();
    super.onClose();
  }
}
