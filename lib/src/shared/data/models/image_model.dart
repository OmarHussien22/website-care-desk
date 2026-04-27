import '../../../core/utils/extensions/json_parsing_extension.dart';
import '../../domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({int? id, String? url}) : super(id: id ?? 0, image: url ?? "");

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json.parseInt("id"),
      url: json.parseString("url"),
    );
  }
}
