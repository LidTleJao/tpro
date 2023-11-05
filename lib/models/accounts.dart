import 'package:json_annotation/json_annotation.dart';
import "account.dart";
part 'accounts.g.dart';

@JsonSerializable()
class Accounts {
  Accounts();

  late List<Account> accounts;
  
  factory Accounts.fromJson(Map<String,dynamic> json) => _$AccountsFromJson(json);
  Map<String, dynamic> toJson() => _$AccountsToJson(this);
}
