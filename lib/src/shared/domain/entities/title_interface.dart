import 'package:equatable/equatable.dart';

    abstract class TitleInterface with EquatableMixin {
  final int id;
  final String title;
  final String? subTitle;
  final String? image;
  final List<TitleInterface>? children;

  const TitleInterface({
    required this.id,
    required this.title,
    this.subTitle,
    this.image,
    this.children,
  });

  @override
  List<Object?> get props => [id, title, subTitle, image, children];
}