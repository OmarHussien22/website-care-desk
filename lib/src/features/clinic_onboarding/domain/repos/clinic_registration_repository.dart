import 'package:coursaty/src/core/network_structure/data_source/service_interface.dart';
import 'package:coursaty/src/core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/clinic_registration_api_service.dart';
import '../../data/models/specialty_model.dart';
import '../entities/specialty_entity.dart';

class ClinicRegistrationRepository
    extends RepoInterface<ClinicRegistrationEntity> {
  ClinicRegistrationRepository._();
  static final instance = ClinicRegistrationRepository._();

  @override
  ServicesInterface get serviceInstance =>
      ClinicRegistrationApiService.instance;

  @override
  ClinicRegistrationEntity Function(dynamic data) get onParse =>
      SpecialtyModel.registrationFromJson;

  @override
  ClinicRegistrationEntity get testData =>
      const ClinicRegistrationEntity(id: 1, name: 'MedDesk Clinic');
}
