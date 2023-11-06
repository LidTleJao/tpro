// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'img.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Img _$ImgFromJson(Map<String, dynamic> json) => Img()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..image = json['image'] as String
  ..url = json['url'] as String
  ..detail = json['detail'] as String
  ..name_type = json['name_type'] as String;

Map<String, dynamic> _$ImgToJson(Img instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'url': instance.url,
      'detail': instance.detail,
      'name_type': instance.name_type,
    };
