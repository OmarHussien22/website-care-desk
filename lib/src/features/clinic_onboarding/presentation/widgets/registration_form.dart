import 'package:coursaty/src/features/clinic_onboarding/domain/entities/specialty_entity.dart';
import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/features/clinic_onboarding/presentation/controllers/clinic_registration_controller.dart';
import 'package:coursaty/src/landing/core/theme/landing_colors.dart';
import 'package:coursaty/src/landing/core/typography/text_role.dart';
import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => GetBuilder<ClinicRegistrationController>(
    builder: (controller) => Form(
      key: controller.globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Field(
            labelKey: 'register.full_name',
            controller: controller.fullNameController,
            validator: controller.requiredValidator,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14.0),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 560.0;
              final country = _Field(
                labelKey: 'register.country',
                controller: controller.countryController,
                validator: controller.requiredValidator,
                textInputAction: TextInputAction.next,
              );
              final phone = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.0,
                    child: _Field(
                      labelKey: 'register.country_code',
                      controller: controller.countryCodeController,
                      validator: controller.requiredValidator,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: _Field(
                      labelKey: 'register.phone',
                      controller: controller.phoneController,
                      validator: controller.phoneValidator,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              );
              return wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: country),
                        const SizedBox(width: 14.0),
                        Expanded(child: phone),
                      ],
                    )
                  : Column(
                      children: [country, const SizedBox(height: 14.0), phone],
                    );
            },
          ),
          const SizedBox(height: 14.0),
          _Field(
            labelKey: 'register.email',
            controller: controller.emailController,
            validator: controller.emailValidator,
            keyboardType: TextInputType.emailAddress,
            textDirection: TextDirection.ltr,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14.0),
          LayoutBuilder(
            builder: (context, constraints) {
              final first = _Field(
                labelKey: 'register.password',
                controller: controller.passwordController,
                validator: controller.passwordValidator,
                obscureText: !controller.showPassword,
                suffixIcon: IconButton(
                  onPressed: controller.togglePasswordVisibility,
                  icon: Icon(
                    controller.showPassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: LandingColors.secondary,
                  ),
                ),
              );
              final second = _Field(
                labelKey: 'register.confirm_password',
                controller: controller.confirmPasswordController,
                validator: controller.confirmPasswordValidator,
                obscureText: !controller.showPassword,
              );
              return constraints.maxWidth >= 560.0
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: first),
                        const SizedBox(width: 14.0),
                        Expanded(child: second),
                      ],
                    )
                  : Column(
                      children: [first, const SizedBox(height: 14.0), second],
                    );
            },
          ),
          const SizedBox(height: 14.0),
          _Field(
            labelKey: 'register.clinic_name',
            controller: controller.clinicNameController,
            validator: controller.requiredValidator,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14.0),
          DropdownButtonFormField<String>(
            initialValue: controller.clinicType,
            onChanged: (value) {
              if (value != null) controller.setClinicType(value);
            },
            items: [
              DropdownMenuItem(
                value: 'doctor',
                child: CustomText(
                  'register.doctor'.tr,
                  role: TextRole.bodyMD,
                  color: LandingColors.textPrimary,
                ),
              ),
              DropdownMenuItem(
                value: 'center',
                child: CustomText(
                  'register.center'.tr,
                  role: TextRole.bodyMD,
                  color: LandingColors.textPrimary,
                ),
              ),
            ],
            decoration: _decoration('register.clinic_type'.tr),
          ),
          const SizedBox(height: 14.0),
          _SpecialtyField(controller: controller),
          if (controller.integrationUnavailable) ...[
            const SizedBox(height: 16.0),
            const _FormNotice(messageKey: 'register.integration_unavailable'),
            if (!controller.specialtiesEndpointAvailable) ...[
              const SizedBox(height: 8.0),
              const _FormNotice(messageKey: 'register.specialties_unavailable'),
            ],
          ],
          if (controller.state is DataFailed<ClinicRegistrationEntity>) ...[
            const SizedBox(height: 16.0),
            _FormNotice(
              message:
                  controller.state.error?.title ?? 'register.server_error'.tr,
              isError: true,
            ),
          ],
          if (controller.state is DataSuccess<ClinicRegistrationEntity>) ...[
            const SizedBox(height: 16.0),
            const _FormNotice(messageKey: 'register.success', isSuccess: true),
          ],
          const SizedBox(height: 22.0),
          ElevatedButton(
            onPressed: controller.isSubmitting ? null : controller.submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: LandingColors.accent,
              foregroundColor: Colors.white,
              disabledBackgroundColor: LandingColors.secondary,
              minimumSize: const Size(double.infinity, 54.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 0,
            ),
            child: controller.isSubmitting
                ? const SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  )
                : CustomText(
                    'register.submit'.tr,
                    role: TextRole.button,
                    fontWeight: FW.bold,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    ),
  );
}

class _SpecialtyField extends StatelessWidget {
  const _SpecialtyField({required this.controller});
  final ClinicRegistrationController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.specialtiesEndpointAvailable) {
      return InputDecorator(
        decoration: _decoration(
          'register.specialty'.tr,
        ).copyWith(enabled: false),
        child: CustomText(
          'register.specialties_unavailable'.tr,
          role: TextRole.bodySM,
          color: LandingColors.textSecondary,
        ),
      );
    }
    if (controller.specialtiesState is DataLoading<List<SpecialtyEntity>>) {
      return InputDecorator(
        decoration: _decoration('register.specialty'.tr),
        child: LinearProgressIndicator(
          color: LandingColors.accent,
          backgroundColor: LandingColors.borderSubtle,
        ),
      );
    }
    final specialties =
        controller.specialtiesState.data ?? const <SpecialtyEntity>[];
    final languageCode = Get.locale?.languageCode ?? 'ar';
    return Autocomplete<SpecialtyEntity>(
      displayStringForOption: (option) => option.localizedName(languageCode),
      optionsBuilder: (value) {
        final query = value.text.trim().toLowerCase();
        if (query.isEmpty) return specialties;
        return specialties.where(
          (specialty) =>
              specialty.nameAr.toLowerCase().contains(query) ||
              specialty.nameEn.toLowerCase().contains(query),
        );
      },
      onSelected: controller.selectSpecialty,
      fieldViewBuilder:
          (context, textController, focusNode, onFieldSubmitted) =>
              TextFormField(
                controller: textController,
                focusNode: focusNode,
                validator: (_) => controller.selectedSpecialty == null
                    ? 'register.required'.tr
                    : null,
                onChanged: (_) {
                  if (controller.selectedSpecialty != null &&
                      textController.text !=
                          controller.selectedSpecialty?.localizedName(
                            languageCode,
                          )) {
                    controller.selectSpecialty(null);
                  }
                },
                style: TextStyle(
                  color: LandingColors.textPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 14.0,
                ),
                decoration: _decoration('register.specialty'.tr).copyWith(
                  hintText: 'register.specialty_hint'.tr,
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: LandingColors.secondary,
                  ),
                ),
              ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.labelKey,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.textDirection,
    this.textInputAction,
  });
  final String labelKey;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    textDirection: textDirection,
    textInputAction: textInputAction,
    style: TextStyle(
      color: LandingColors.textPrimary,
      fontFamily: 'Montserrat',
      fontSize: 14.0,
    ),
    decoration: _decoration(labelKey.tr).copyWith(suffixIcon: suffixIcon),
  );
}

InputDecoration _decoration(String label) => InputDecoration(
  labelText: label,
  labelStyle: TextStyle(
    color: LandingColors.textSecondary,
    fontFamily: 'Montserrat',
    fontSize: 13.0,
  ),
  filled: true,
  fillColor: LandingColors.surfaceMuted,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: LandingColors.borderSubtle),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: LandingColors.borderSubtle),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: LandingColors.accent, width: 1.5),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.red.shade400),
  ),
);

class _FormNotice extends StatelessWidget {
  const _FormNotice({
    this.messageKey,
    this.message,
    this.isError = false,
    this.isSuccess = false,
  });
  final String? messageKey;
  final String? message;
  final bool isError;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    final color = isError
        ? Colors.red.shade600
        : isSuccess
        ? LandingColors.success
        : LandingColors.secondary;
    return Container(
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isError
                ? Icons.error_outline_rounded
                : isSuccess
                ? Icons.check_circle_outline_rounded
                : Icons.info_outline_rounded,
            color: color,
            size: 19.0,
          ),
          const SizedBox(width: 9.0),
          Expanded(
            child: CustomText(
              message ?? messageKey?.tr ?? '',
              role: TextRole.bodySM,
              color: LandingColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
