import 'package:json_annotation/json_annotation.dart';
import "com.dart";
part 'coms.g.dart';

@JsonSerializable()
class Coms {
  Coms();

  late List<Com> coms;
  
  factory Coms.fromJson(Map<String,dynamic> json) => _$ComsFromJson(json);
  Map<String, dynamic> toJson() => _$ComsToJson(this);
}
