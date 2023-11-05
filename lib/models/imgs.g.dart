// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imgs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Imgs _$ImgsFromJson(Map<String, dynamic> json) => Imgs()
  ..imgs = (json['imgs'] as List<dynamic>)
      .map((e) => Img.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ImgsToJson(Imgs instance) => <String, dynamic>{
      'imgs': instance.imgs,
    };
