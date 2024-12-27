import 'dart:convert';

NotesEntity notesEntityFromJson(String str) => NotesEntity.fromJson(json.decode(str));

class NotesEntity {
  final String message;
  final String method;
  final List<NotesData> notes;

  NotesEntity({
    required this.message,
    required this.method,
    required this.notes,
  });

  factory NotesEntity.fromJson(Map<String, dynamic> json) => NotesEntity(
        message: json["message"],
        method: json["method"],
        notes: json["values"] == null
            ? []
            : List<NotesData>.from(
                json["values"].map((x) => NotesData.fromJson(x)),
              ),
      );
}

class NotesData {
  final String id;
  final String notes;
  final String title;

  NotesData({
    required this.id,
    required this.notes,
    required this.title,
  });

  factory NotesData.fromJson(Map<String, dynamic> json) => NotesData(
        id: json["id"],
        notes: json["notes"],
        title: json["title"],
      );
}
