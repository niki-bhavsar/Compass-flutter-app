import 'dart:convert';

LoginEntity loginEntityFromJson(String str) => LoginEntity.fromJson(json.decode(str));

class LoginEntity {
  final LoginInfo data;

  LoginEntity({
    required this.data,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
        data: LoginInfo.fromJson(json["values"]),
      );
}

class LoginInfo {
  final String accountId;
  final String accountName;
  final String accountEmail;

  LoginInfo({
    required this.accountId,
    required this.accountName,
    required this.accountEmail,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
        accountId: json["account_id"],
        accountName: json["account_name"],
        accountEmail: json["account_email"],
      );
}
