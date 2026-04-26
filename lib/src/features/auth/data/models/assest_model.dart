import 'package:equatable/equatable.dart';

class AssestModel with EquatableMixin {
  final int id;
  final String url;
  final String assestName;

  const AssestModel({
    required this.id,
    required this.url,
    required this.assestName,
  });

  factory AssestModel.fromJson(Map<String, dynamic> json) {
    return AssestModel(
      id: json['id'] ?? 0,
      url: json['image'] ?? '',
      assestName: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': url,
      'name': assestName,
    };
  }

  @override
  List<Object?> get props => [id, url, assestName];
}
