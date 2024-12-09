import 'dart:convert';

ChangePasswordEntity changePasswordEntityFromJson(String str) =>
    ChangePasswordEntity.fromJson(json.decode(str));

class ChangePasswordEntity {
  final String? message;
  final String? status;
  final String? method;

  ChangePasswordEntity({
    this.message,
    this.status,
    this.method,
  });

  factory ChangePasswordEntity.fromJson(Map<String, dynamic> json) => ChangePasswordEntity(
        message: json["message"],
        status: json["status"],
        method: json["method"],
      );
}
