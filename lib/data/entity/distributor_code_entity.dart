import 'dart:convert';

DistributorEntity distributorCodeEntityFromJson(String str) =>
    DistributorEntity.fromJson(json.decode(str));

class DistributorEntity {
  final String? status;
  final String? message;
  final int? error;
  final DistributorInfo? distributorInfo;

  DistributorEntity({
    this.status,
    this.error,
    this.message,
    this.distributorInfo,
  });

  factory DistributorEntity.fromJson(Map<String, dynamic> json) => DistributorEntity(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        distributorInfo: json["values"] == null ? null : DistributorInfo.fromJson(json["values"]),
      );
}

class DistributorInfo {
  final String webId;
  final String webName;
  final String webDBSuffix;
  final String logoUrl;

  DistributorInfo({
    required this.webId,
    required this.webName,
    required this.webDBSuffix,
    required this.logoUrl,
  });

  factory DistributorInfo.fromJson(Map<String, dynamic> json) => DistributorInfo(
        webId: json["webid"],
        webName: json["webname"],
        webDBSuffix: json["webdbsuffix"],
        logoUrl: json["logourl"],
      );
}
