// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accounts _$AccountsFromJson(Map<String, dynamic> json) => Accounts()
  ..accounts = (json['accounts'] as List<dynamic>)
      .map((e) => Account.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$AccountsToJson(Accounts instance) => <String, dynamic>{
      'accounts': instance.accounts,
    };
