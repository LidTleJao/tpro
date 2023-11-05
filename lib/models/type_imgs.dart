import 'package:json_annotation/json_annotation.dart';
import "type_img.dart";
part 'type_imgs.g.dart';

@JsonSerializable()
class Type_imgs {
  Type_imgs();

  late List<Type_img> type_imgs;
  
  factory Type_imgs.fromJson(Map<String,dynamic> json) => _$Type_imgsFromJson(json);
  Map<String, dynamic> toJson() => _$Type_imgsToJson(this);
}
