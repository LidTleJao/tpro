import 'package:json_annotation/json_annotation.dart';

part 'img.g.dart';

@JsonSerializable()
class Img {
  Img();

  late num id;
  late num id_account;
  late String name;
  late String image;
  late String url;
  late String detail;
  late num id_type;
  late String name_type;
  late num count_comment;
  late num count_like;
  
  factory Img.fromJson(Map<String,dynamic> json) => _$ImgFromJson(json);
  Map<String, dynamic> toJson() => _$ImgToJson(this);
}
