// To parse this JSON data, do
//
//     final techniqueLibraryEntity = techniqueLibraryEntityFromJson(jsonString);

import 'dart:convert';

import 'package:compass_software/utils/intl_utils.dart';

TechniqueLibraryEntity techniqueLibraryEntityFromJson(String str) =>
    TechniqueLibraryEntity.fromJson(json.decode(str));

class TechniqueLibraryEntity {
  String message;
  List<TechniqueLibraryInfo> values;

  TechniqueLibraryEntity({
    required this.message,
    required this.values,
  });

  factory TechniqueLibraryEntity.fromJson(Map<String, dynamic> json) => TechniqueLibraryEntity(
        message: json["message"],
        values: List<TechniqueLibraryInfo>.from(
            json["values"].map((x) => TechniqueLibraryInfo.fromJson(x))),
      );
}

class TechniqueLibraryInfo {
  String id;
  String title;
  String fileUrl;
  String anatomy;
  String system;
  String description;
  DateTime? createDate;

  TechniqueLibraryInfo({
    required this.id,
    required this.title,
    required this.fileUrl,
    required this.anatomy,
    required this.system,
    required this.description,
    required this.createDate,
  });

  factory TechniqueLibraryInfo.fromJson(Map<String, dynamic> json) => TechniqueLibraryInfo(
        id: json["id"],
        title: json["title"],
        fileUrl: json["file_url"],
        anatomy: json["anatomy"]!,
        system: json["system"],
        description: json["description"],
        createDate: IntlUtil.parseDate(json["create_date"]),
      );
}
