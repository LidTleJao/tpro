// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account()
  ..id = json['id'] as num
  ..image = json['image'] as String
  ..name = json['name'] as String
  ..phone = json['phone'] as String
  ..address = json['address'] as String
  ..gmail = json['gmail'] as String
  ..password = json['password'] as String;

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'gmail': instance.gmail,
      'password': instance.password,
    };
