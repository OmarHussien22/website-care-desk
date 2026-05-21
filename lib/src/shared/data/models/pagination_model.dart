import 'package:coursaty/src/core/utils/general_utils.dart';

import '../../domain/entities/pagination_entity.dart';

class PaginationModel extends PaginationEntity {
  PaginationModel({
    int? next,
    int? prev,
    int? total,
    required int current,
    int? count,
    required int last,
  }) : super(
         next: next,
         total: total,
         count: count,
         current: current,
         last: last,
         prev: prev,
       );

  factory PaginationModel.fromJson(Map<String, dynamic> map) {
    return PaginationModel(
      prev: map['from'] ?? 0,
      count: map['per_page'] ?? 0,
      next: map['to'] ?? 0,
      last: map['last_page'] ?? 0,
      current: map['current_page'] ?? 0,
      total: map['total'] ?? 0,
    );
  }
}
