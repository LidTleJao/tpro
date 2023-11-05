// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coms _$ComsFromJson(Map<String, dynamic> json) => Coms()
  ..coms = (json['coms'] as List<dynamic>)
      .map((e) => Com.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ComsToJson(Coms instance) => <String, dynamic>{
      'coms': instance.coms,
    };
