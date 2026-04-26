import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? current;
  final int? last;
  final int? count;
  final int? total;
  final int? prev;
  final int? next;

  const Pagination({
    this.current,
    this.last,
    this.count,
    this.total,
    this.prev,
    this.next,
  });

  @override
  List<Object?> get props => [
    current,
    last,
    count,
    total,
    prev,
    next,
  ];

  @override
  bool get stringify => true;
}
