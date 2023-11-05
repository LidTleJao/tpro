import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  Account();

  late num id;
  late String image;
  late String name;
  late String phone;
  late String address;
  late String gmail;
  late String password;
  
  factory Account.fromJson(Map<String,dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
