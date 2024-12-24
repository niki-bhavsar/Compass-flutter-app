import 'dart:convert';

HospitalContactEntity hospitalContactEntityFromJson(String str) =>
    HospitalContactEntity.fromJson(json.decode(str));

class HospitalContactEntity {
  final String message;
  final String method;
  final List<HospitalContact> hospitalContacts;

  HospitalContactEntity({
    required this.message,
    required this.method,
    required this.hospitalContacts,
  });

  factory HospitalContactEntity.fromJson(Map<String, dynamic> json) => HospitalContactEntity(
        message: json["message"],
        method: json["method"],
        hospitalContacts: json["values"] == null
            ? []
            : List<HospitalContact>.from(json["values"].map((x) => HospitalContact.fromJson(x))),
      );
}

class HospitalContact {
  final String id;
  final String name;
  final String email;

  HospitalContact({
    required this.id,
    required this.name,
    required this.email,
  });

  factory HospitalContact.fromJson(Map<String, dynamic> json) => HospitalContact(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );
}
