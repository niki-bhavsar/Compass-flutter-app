import 'dart:convert';

DistributorCodeEntity distributorCodeEntityFromJson(String str) => DistributorCodeEntity.fromJson(json.decode(str));

class DistributorCodeEntity {
  final String? method;
  final String? status;
  final int? error;
  final DistributorInfo distributorInfo;

  DistributorCodeEntity({
     this.method,
    this.status,
    this.error,
    required this.distributorInfo,
  });

  factory DistributorCodeEntity.fromJson(Map<String, dynamic> json) => DistributorCodeEntity(
    method: json["method"],
    status: json["status"],
    error: json["error"],
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
