// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'img.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Img _$ImgFromJson(Map<String, dynamic> json) => Img()
  ..id = json['id'] as num
  ..id_account = json['id_account'] as num
  ..name = json['name'] as String
  ..image = json['image'] as String
  ..url = json['url'] as String
  ..detail = json['detail'] as String
  ..id_type = json['id_type'] as num
  ..name_type = json['name_type'] as String
  ..count_comment = json['count_comment'] as num
  ..count_like = json['count_like'] as num;

Map<String, dynamic> _$ImgToJson(Img instance) => <String, dynamic>{
      'id': instance.id,
      'id_account': instance.id_account,
      'name': instance.name,
      'image': instance.image,
      'url': instance.url,
      'detail': instance.detail,
      'id_type': instance.id_type,
      'name_type': instance.name_type,
      'count_comment': instance.count_comment,
      'count_like': instance.count_like,
    };
