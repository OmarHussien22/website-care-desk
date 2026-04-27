
import '../../domain/entities/stage_entity.dart';

class StageModel extends StageEntity{
  StageModel({required super.id, required super.title});



  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      id: json['id']??0,
      title: json['title']??"",
    );
  }
}