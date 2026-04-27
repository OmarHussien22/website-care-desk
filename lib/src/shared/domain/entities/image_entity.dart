import '../../../core/utils/extensions/json_parsing_extension.dart';
import '../../presentation/widgets/general_widgets/image/generic_image/generic_image.dart';

class ImageEntity {
  final int id;
  final dynamic image;
  final ImageType type;
  ImageEntity({
    required this.id,
    required this.image,
     this.type = ImageType.network,
  });

  factory ImageEntity.fromJson(Map<String, dynamic> json) {
    return ImageEntity(
      id: json.parseInt("id"),
      image: json.parseString("url"),

    );
  }
}
