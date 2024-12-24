import 'dart:convert';

FavouriteProcedureEntity favouriteProcedureEntityFromJson(String str) =>
    FavouriteProcedureEntity.fromJson(json.decode(str));

class FavouriteProcedureEntity {
  final String message;
  final String method;
  final List<ProcedureList> favouriteProcedure;
  final List<Procedure> procedures;

  FavouriteProcedureEntity({
    required this.message,
    required this.method,
    required this.favouriteProcedure,
    required this.procedures,
  });

  factory FavouriteProcedureEntity.fromJson(Map<String, dynamic> json) => FavouriteProcedureEntity(
        message: json["message"],
        method: json["method"],
        favouriteProcedure: json["values"]["favorite_procedures"] == null
            ? []
            : List<ProcedureList>.from(
                json["values"]["favorite_procedures"].map((x) => ProcedureList.fromJson(x))),
        procedures: json["values"]["procedures"] == null
            ? []
            : List<Procedure>.from(json["values"]["procedures"].map((x) => Procedure.fromJson(x))),
      );
}

class Procedure {
  final int? id;
  final String? name;
  final int? header;
  final List<ProcedureList>? procedureData;

  Procedure({
    this.id,
    this.name,
    this.header,
    this.procedureData,
  });

  factory Procedure.fromJson(Map<String, dynamic> json) => Procedure(
        id: json["id"] == null ? 0 : int.parse(json["id"].toString()),
        name: json["name"],
        header: json["header"],
        procedureData: json["values"] == null
            ? []
            : List<ProcedureList>.from(json["values"].map((x) => ProcedureList.fromJson(x))),
      );
}

class ProcedureList {
  int? id;
  int? procedureId;
  String? procedureName;
  String? nickName;
  int? header;

  ProcedureList({
    this.id,
    this.procedureId,
    this.procedureName,
    this.nickName,
    this.header,
  });

  factory ProcedureList.fromRawJson(String str) => ProcedureList.fromJson(json.decode(str));

  factory ProcedureList.fromJson(Map<String, dynamic> json) => ProcedureList(
        id: json["id"] == null ? 0 : int.parse(json["id"].toString()),
        procedureId: json["procedure_id"] == null ? 0 : int.parse(json["procedure_id"].toString()),
        procedureName: json["procedure_name"],
        nickName: json["nickname"],
        header: json["header"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": procedureId ?? "",
        "nickname": nickName ?? "",
      };
}
