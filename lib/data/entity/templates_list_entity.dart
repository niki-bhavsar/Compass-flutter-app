// To parse this JSON data, do
//
//     final templateListEntity = templateListEntityFromJson(jsonString);

import 'dart:convert';

import 'package:compass_software/utils/intl_utils.dart';

TemplateListEntity templateListEntityFromJson(String str) =>
    TemplateListEntity.fromJson(json.decode(str));

class TemplateListEntity {
  String? message;
  List<TemplateListInfo>? values;

  TemplateListEntity({
    this.message,
    this.values,
  });

  factory TemplateListEntity.fromJson(Map<String, dynamic> json) => TemplateListEntity(
        message: json["message"],
        values: json["values"] == null
            ? []
            : List<TemplateListInfo>.from(json["values"]!.map((x) => TemplateListInfo.fromJson(x))),
      );
}

class TemplateListInfo {
  String? id;
  String? name;
  DateTime? dateCreated;

  TemplateListInfo({
    this.id,
    this.name,
    this.dateCreated,
  });

  factory TemplateListInfo.fromJson(Map<String, dynamic> json) => TemplateListInfo(
        id: json["id"],
        name: json["name"],
        dateCreated: IntlUtil.parseDate(json["date_created"]),
      );
}
