// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'com.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Com _$ComFromJson(Map<String, dynamic> json) => Com()
  ..id_image = json['id_image'] as num
  ..id_account = json['id_account'] as num
  ..name = json['name'] as String
  ..image = json['image'] as String
  ..description = json['description'] as String;

Map<String, dynamic> _$ComToJson(Com instance) => <String, dynamic>{
      'id_image': instance.id_image,
      'id_account': instance.id_account,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
    };
