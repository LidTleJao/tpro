import 'package:json_annotation/json_annotation.dart';

part 'com.g.dart';

@JsonSerializable()
class Com {
  Com();

  late num id_image;
  late num id_account;
  late String name;
  late String image;
  late String description;
  
  factory Com.fromJson(Map<String,dynamic> json) => _$ComFromJson(json);
  Map<String, dynamic> toJson() => _$ComToJson(this);
}
