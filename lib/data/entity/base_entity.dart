import 'dart:convert';

BaseEntity baseEntityFromJson(String str) => BaseEntity.fromJson(json.decode(str));

class BaseEntity {
  final String message;
  final bool isSuccess;
  final String? error;
  final Map<String, dynamic>? additional;

  BaseEntity({
    required this.message,
    this.isSuccess = false,
    this.error,
    this.additional,
  });

  factory BaseEntity.fromJson(Map<String, dynamic> json) => BaseEntity(
        message: json["message"] ?? "",
        error: json["error"] != null ? json["error"].toString() : "",
        isSuccess: json["error"] == 0,
        additional: json,
      );

  factory BaseEntity.dummy() => BaseEntity(
        message: "",
      );

  @override
  String toString() {
    return 'BaseEntity{message: $message, additional: $additional}';
  }
}
