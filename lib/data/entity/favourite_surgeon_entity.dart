import 'dart:convert';

FavouriteSurgeonEntity favouriteSurgeonEntityFromJson(String str) =>
    FavouriteSurgeonEntity.fromJson(json.decode(str));

class FavouriteSurgeonEntity {
  final String message;
  final String method;
  final List<SurgeonList> surgeons;
  final List<SurgeonList> favouriteSurgeons;

  FavouriteSurgeonEntity({
    required this.message,
    required this.method,
    required this.surgeons,
    required this.favouriteSurgeons,
  });

  factory FavouriteSurgeonEntity.fromJson(Map<String, dynamic> json) => FavouriteSurgeonEntity(
        message: json["message"],
        method: json["method"],
        surgeons: json["values"]["surgeons"] == null
            ? []
            : List<SurgeonList>.from(
                json["values"]["surgeons"].map((x) => SurgeonList.fromJson(x))),
        favouriteSurgeons: json["values"]["favorite_surgeons"] == null
            ? []
            : List<SurgeonList>.from(
                json["values"]["favorite_surgeons"].map((x) => SurgeonList.fromJson(x))),
      );
}

class SurgeonList {
  int? id;
  String? surgeonId;
  String? firstName;
  String? lastName;
  String? nickName;
  String? suffix;

  SurgeonList({
    this.id,
    this.surgeonId,
    this.firstName,
    this.lastName,
    this.nickName,
    this.suffix,
  });

  String surgeonName() => "$firstName $lastName".trim();

  factory SurgeonList.fromJson(Map<String, dynamic> json) => SurgeonList(
        id: json["id"],
        surgeonId: json["surgeon_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nickName: json["nickname"],
        suffix: json["suffix"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": surgeonId ?? "",
        "nickname": nickName ?? "",
      };

  @override
  String toString() {
    return 'SurgeonList{id: $id, surgeonId: $surgeonId, firstName: $firstName, lastName: $lastName, nickName: $nickName, suffix: $suffix}';
  }
}
