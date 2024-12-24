import 'dart:convert';

HospitalDetailEntity hospitalDetailEntityFromJson(String str) =>
    HospitalDetailEntity.fromJson(json.decode(str));

class HospitalDetailEntity {
  String? method;
  String? message;
  HospitalDetail hospitalDetail;

  HospitalDetailEntity({
    this.method,
    this.message,
    required this.hospitalDetail,
  });

  factory HospitalDetailEntity.fromJson(Map<String, dynamic> json) => HospitalDetailEntity(
        message: json["message"],
        method: json["method"],
        hospitalDetail: HospitalDetail.fromJson(json["values"]),
      );
}

class HospitalDetail {
  String? id;
  String? name;
  String? accountNumber;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? phone;
  String? photo;
  String? traumaRep;
  String? mitekRep;
  String? reconRep;
  String? spineRep;
  String? coverageInfo;
  String? contractInfo;
  String? contractStart;
  String? contractExpire;
  String? hospitalSystem;
  String? hospitalSystemLogo;
  String? credInfoId;
  String? credInfoName;
  String? credInfoLogo;
  String? createDate;
  List<CredInfoList?>? credInfoList;

  HospitalDetail({
    this.id,
    this.name,
    this.accountNumber,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.phone,
    this.photo,
    this.traumaRep,
    this.mitekRep,
    this.reconRep,
    this.spineRep,
    this.coverageInfo,
    this.contractInfo,
    this.contractStart,
    this.contractExpire,
    this.hospitalSystem,
    this.hospitalSystemLogo,
    this.credInfoId,
    this.credInfoName,
    this.credInfoLogo,
    this.createDate,
    this.credInfoList,
  });

  String? fullAddress() => "$address1 $address2 $city, $state $zip".trim();

  factory HospitalDetail.fromJson(Map<String, dynamic> json) => HospitalDetail(
        id: json['id'],
        name: json['name'],
        accountNumber: json['accountNumber'],
        address1: json['address1'],
        address2: json['address2'],
        city: json['city'],
        state: json['state'],
        zip: json['zip'],
        phone: json['phone'],
        photo: json['photo'],
        traumaRep: json['traumaRep'],
        mitekRep: json['mitekRep'],
        reconRep: json['reconRep'],
        spineRep: json['spineRep'],
        coverageInfo: json['coverageInfo'],
        contractInfo: json['contractInfo'],
        contractStart: json['contractStart'],
        contractExpire: json['contractExpire'],
        hospitalSystem: json['hospitalSystem'],
        hospitalSystemLogo: json['hospitalSystemLogo'],
        credInfoId: json['credInfoId'],
        credInfoName: json['credInfoName'],
        credInfoLogo: json['credInfoLogo'],
        createDate: json['createDate'],
        credInfoList: json["credInfoList"] == null
            ? []
            : List<CredInfoList>.from(json["credInfoList"].map((x) => CredInfoList.fromJson(x))),
      );
}

class CredInfoList {
  String? id;
  String? name;

  CredInfoList({
    this.id,
    this.name,
  });

  factory CredInfoList.fromJson(Map<String, dynamic> json) => CredInfoList(
        id: json['id'],
        name: json['name'],
      );
}
