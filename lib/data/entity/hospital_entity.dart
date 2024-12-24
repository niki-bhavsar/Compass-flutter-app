import 'dart:convert';

HospitalEntity hospitalEntityFromJson(String str) => HospitalEntity.fromJson(json.decode(str));

class HospitalEntity {
  final String message;
  final String method;
  final List<HospitalData> hospitals;

  HospitalEntity({
    required this.message,
    required this.method,
    required this.hospitals,
  });

  factory HospitalEntity.fromJson(Map<String, dynamic> json) => HospitalEntity(
        message: json["message"],
        method: json["method"],
        hospitals: json["values"] == null
            ? []
            : List<HospitalData>.from(json["values"].map((x) => HospitalData.fromJson(x))),
      );
}

class HospitalData {
  final String hospitalId;
  final String title;

  HospitalData({
    required this.hospitalId,
    required this.title,
  });

  factory HospitalData.fromJson(Map<String, dynamic> json) => HospitalData(
        hospitalId: json["id"],
        title: json["title"],
      );
}
