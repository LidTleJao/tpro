import 'package:json_annotation/json_annotation.dart';
import "img.dart";
part 'imgs.g.dart';

@JsonSerializable()
class Imgs {
  Imgs();

  late List<Img> imgs;
  
  factory Imgs.fromJson(Map<String,dynamic> json) => _$ImgsFromJson(json);
  Map<String, dynamic> toJson() => _$ImgsToJson(this);
}
