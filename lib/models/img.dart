import 'package:json_annotation/json_annotation.dart';

part 'img.g.dart';

@JsonSerializable()
class Img {
  Img();

  late num id;
  late String name;
  late String image;
  late String url;
  late String detail;
  late String name_type;
  
  factory Img.fromJson(Map<String,dynamic> json) => _$ImgFromJson(json);
  Map<String, dynamic> toJson() => _$ImgToJson(this);
}
