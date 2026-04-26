import 'package:coursaty/src/features/auth/domain/entities/avatar_entity.dart';

class AvatarModel extends Avatar {
  const AvatarModel({
    required int id,
    required String url,
    String? title,
  }) : super(
          id: id,
          url: url,
        );

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      id: json['id'] ?? 0,
      url: json['image'] ?? '',
    );
  }

  static const List<Avatar> avatars = [
    Avatar(id: 1, url: 'assets/images/avatar1.png'),
    Avatar(id: 2, url: 'assets/images/avatar2.png'),
    Avatar(id: 3, url: 'assets/images/avatar3.png'),
    Avatar(id: 4, url: 'assets/images/avatar4.png'),
    Avatar(id: 5, url: 'assets/images/avatar5.png'),
    Avatar(id: 6, url: 'assets/images/avatar6.png'),
    Avatar(id: 7, url: 'assets/images/avatar7.png'),
    Avatar(id: 8, url: 'assets/images/avatar8.png'),
    Avatar(id: 9, url: 'assets/images/avatar9.png'),
  ];
}
