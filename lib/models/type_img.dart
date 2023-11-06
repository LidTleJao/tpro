import 'package:json_annotation/json_annotation.dart';

part 'type_img.g.dart';

@JsonSerializable()
class Type_img {
  Type_img();

  late num id;
  late String name_type;
  
  factory Type_img.fromJson(Map<String,dynamic> json) => _$Type_imgFromJson(json);
  Map<String, dynamic> toJson() => _$Type_imgToJson(this);
}
