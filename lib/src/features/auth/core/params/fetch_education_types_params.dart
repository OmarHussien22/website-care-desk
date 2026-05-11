import '../../../../core/network_structure/params/params.dart';

class FetchEducationTypesParams extends Params {
  final int? id;

  FetchEducationTypesParams({this.id});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
