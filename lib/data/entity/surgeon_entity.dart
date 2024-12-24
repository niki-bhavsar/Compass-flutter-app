import 'dart:convert';

SurgeonEntity surgeonEntityFromJson(String str) => SurgeonEntity.fromJson(json.decode(str));

class SurgeonEntity {
  final String message;
  final String method;
  final List<SurgeonData> surgeons;

  SurgeonEntity({
    required this.message,
    required this.method,
    required this.surgeons,
  });

  factory SurgeonEntity.fromJson(Map<String, dynamic> json) => SurgeonEntity(
        message: json["message"],
        method: json["method"],
        surgeons: json["values"] == null
            ? []
            : List<SurgeonData>.from(json["values"].map((x) => SurgeonData.fromJson(x))),
      );
}

class SurgeonData {
  final String surgeonId;
  final String title;

  SurgeonData({
    required this.surgeonId,
    required this.title,
  });

  factory SurgeonData.fromJson(Map<String, dynamic> json) => SurgeonData(
        surgeonId: json["id"],
        title: json["title"],
      );
}
