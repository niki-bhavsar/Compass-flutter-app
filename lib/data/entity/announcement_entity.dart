import 'dart:convert';

import 'package:compass_software/utils/intl_utils.dart';

AnnouncementsEntity announcementsEntityFromJson(String str) =>
    AnnouncementsEntity.fromJson(json.decode(str));

class AnnouncementsEntity {
  String message;
  List<AnnouncementInfo> values;

  AnnouncementsEntity({
    required this.message,
    required this.values,
  });

  factory AnnouncementsEntity.fromJson(Map<String, dynamic> json) => AnnouncementsEntity(
        message: json["message"],
        values:
            List<AnnouncementInfo>.from(json["values"].map((x) => AnnouncementInfo.fromJson(x))),
      );
}

class AnnouncementInfo {
  String id;
  String title;
  String description;
  DateTime? createDate;

  AnnouncementInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.createDate,
  });

  factory AnnouncementInfo.fromJson(Map<String, dynamic> json) => AnnouncementInfo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createDate: IntlUtil.parseDate(json["create_date"]),
      );
}
