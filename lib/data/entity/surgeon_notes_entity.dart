import 'dart:convert';

SurgeonNotesEntity surgeonNotesEntityFromJson(String str) =>
    SurgeonNotesEntity.fromJson(json.decode(str));

class SurgeonNotesEntity {
  final String message;
  final String method;
  final List<SurgeonNotesData> surgeonNotes;

  SurgeonNotesEntity({
    required this.message,
    required this.method,
    required this.surgeonNotes,
  });

  factory SurgeonNotesEntity.fromJson(Map<String, dynamic> json) => SurgeonNotesEntity(
        message: json["message"],
        method: json["method"],
        surgeonNotes: json["values"] == null
            ? []
            : List<SurgeonNotesData>.from(json["values"].map((x) => SurgeonNotesData.fromJson(x))),
      );
}

class SurgeonNotesData {
  final String id;
  final String notes;
  final String title;

  SurgeonNotesData({
    required this.id,
    required this.notes,
    required this.title,
  });

  factory SurgeonNotesData.fromJson(Map<String, dynamic> json) => SurgeonNotesData(
        id: json["id"],
        notes: json["notes"],
        title: json["title"],
      );
}
