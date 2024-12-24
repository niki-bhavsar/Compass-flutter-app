import 'dart:convert';

HospitalNotesEntity hospitalNotesEntityFromJson(String str) =>
    HospitalNotesEntity.fromJson(json.decode(str));

class HospitalNotesEntity {
  final String message;
  final String method;
  final List<HospitalNotesData> hospitalNotes;

  HospitalNotesEntity({
    required this.message,
    required this.method,
    required this.hospitalNotes,
  });

  factory HospitalNotesEntity.fromJson(Map<String, dynamic> json) => HospitalNotesEntity(
        message: json["message"],
        method: json["method"],
        hospitalNotes: json["values"] == null
            ? []
            : List<HospitalNotesData>.from(
                json["values"].map((x) => HospitalNotesData.fromJson(x))),
      );
}

class HospitalNotesData {
  final String id;
  final String notes;
  final String title;

  HospitalNotesData({
    required this.id,
    required this.notes,
    required this.title,
  });

  factory HospitalNotesData.fromJson(Map<String, dynamic> json) => HospitalNotesData(
        id: json["id"],
        notes: json["notes"],
        title: json["title"],
      );
}
