import 'package:coursaty/src/core/network_structure/data_source/service_interface.dart';
import 'package:coursaty/src/core/network_structure/repository/repo_interface.dart';
import '../../data/data_sources/specialties_api_service.dart';
import '../../data/models/specialty_model.dart';
import '../entities/specialty_entity.dart';

class SpecialtiesRepository extends RepoInterface<List<SpecialtyEntity>> {
  SpecialtiesRepository._();
  static final instance = SpecialtiesRepository._();

  @override
  ServicesInterface get serviceInstance => SpecialtiesApiService.instance;

  @override
  List<SpecialtyEntity> Function(dynamic data) get onParse =>
      SpecialtyModel.listFromJson;

  @override
  List<SpecialtyEntity> get testData => const [];
}
