import 'package:coursaty/src/core/network_structure/params/params.dart';
import 'package:coursaty/src/core/network_structure/resources/data_state/data_state.dart';
import 'package:coursaty/src/super/use_case/user_case.dart';
import '../entities/specialty_entity.dart';
import '../repos/specialties_repository.dart';

class FetchSpecialtiesUseCase extends UseCase<List<SpecialtyEntity>, NOParams> {
  @override
  Future<DataState<List<SpecialtyEntity>>>? call({NOParams? params}) =>
      SpecialtiesRepository.instance.call(params: params);
}
