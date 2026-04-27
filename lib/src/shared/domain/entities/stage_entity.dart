import 'title_interface.dart';

class StageEntity extends TitleInterface{
  StageEntity({required super.id, required super.title});
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
  ];
}