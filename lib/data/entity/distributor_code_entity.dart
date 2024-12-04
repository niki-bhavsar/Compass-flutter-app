import 'dart:convert';

DistributorEntity distributorCodeEntityFromJson(String str) =>
    DistributorEntity.fromJson(json.decode(str));

class DistributorEntity {
  final String? status;
  final String? message;
  final int? error;
  final DistributorInfo distributorInfo;

  DistributorEntity({
    this.status,
    this.error,
    this.message,
    required this.distributorInfo,
  });

  factory DistributorEntity.fromJson(Map<String, dynamic> json) => DistributorEntity(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        distributorInfo: DistributorInfo.fromJson(json["values"]),
      );
}

class DistributorInfo {
  final String webId;
  final String webName;
  final String webDBSuffix;
  final String appStatus;
  final String webSuffix;
  final String logoUrl;
  final String refUrl;

  DistributorInfo({
    required this.webId,
    required this.webName,
    required this.webDBSuffix,
    required this.appStatus,
    required this.webSuffix,
    required this.logoUrl,
    required this.refUrl,
  });

  factory DistributorInfo.fromJson(Map<String, dynamic> json) => DistributorInfo(
        webId: json["webid"],
        webName: json["webname"],
        webDBSuffix: json["webdbsuffix"],
        appStatus: json["app_status"],
        webSuffix: json["websuffix"],
        logoUrl: json["logourl"],
        refUrl: json["ref_url"],
      );
}
