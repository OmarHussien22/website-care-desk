import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  int? current;
  int? last;
  int? count;
  int? total;
  int? prev;
  int? next;

  PaginationEntity({
    this.current,
    this.last,
    this.count,
    this.total,
    this.prev,
    this.next,
  });

  @override
  List<Object?> get props => [current, last, count, total, prev, next];

  @override
  bool get stringify => true;
}
