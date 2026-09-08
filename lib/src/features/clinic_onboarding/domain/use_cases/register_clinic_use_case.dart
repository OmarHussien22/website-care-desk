import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/features/clinic_onboarding/core/params/clinic_registration_params.dart';
import 'package:coursaty/src/super/use_case/user_case.dart';
import '../entities/specialty_entity.dart';
import '../repos/clinic_registration_repository.dart';

class RegisterClinicUseCase
    extends UseCase<ClinicRegistrationEntity, ClinicRegistrationParams> {
  @override
  Future<DataState<ClinicRegistrationEntity>>? call({
    ClinicRegistrationParams? params,
  }) => ClinicRegistrationRepository.instance.call(params: params);
}
