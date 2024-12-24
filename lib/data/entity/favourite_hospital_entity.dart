import 'dart:convert';

FavouriteHospitalEntity favouriteHospitalEntityFromJson(String str) =>
    FavouriteHospitalEntity.fromJson(json.decode(str));

class FavouriteHospitalEntity {
  final String message;
  final String method;
  final List<HospitalList> hospitals;
  final List<HospitalList> favouriteHospitals;

  FavouriteHospitalEntity({
    required this.message,
    required this.method,
    required this.hospitals,
    required this.favouriteHospitals,
  });

  factory FavouriteHospitalEntity.fromJson(Map<String, dynamic> json) => FavouriteHospitalEntity(
        message: json["message"],
        method: json["method"],
        hospitals: json["values"]["hospitals"] == null
            ? []
            : List<HospitalList>.from(
                json["values"]["hospitals"].map((x) => HospitalList.fromJson(x))),
        favouriteHospitals: json["values"]["favorite_hospitals"] == null
            ? []
            : List<HospitalList>.from(
                json["values"]["favorite_hospitals"].map((x) => HospitalList.fromJson(x))),
      );
}

class HospitalList {
  int? id;
  String? hospitalId;
  String? name;
  String? nickName;

  HospitalList({
    this.id,
    this.hospitalId,
    this.name,
    this.nickName,
  });

  factory HospitalList.fromJson(Map<String, dynamic> json) => HospitalList(
        id: json["id"],
        hospitalId: json["hospital_id"],
        name: json["name"],
        nickName: json["nickname"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": hospitalId ?? "",
        "nickname": nickName ?? "",
      };
}
