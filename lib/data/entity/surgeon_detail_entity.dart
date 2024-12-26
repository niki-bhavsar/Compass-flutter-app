import 'dart:convert';

SurgeonDetailEntity surgeonDetailEntityFromJson(String str) =>
    SurgeonDetailEntity.fromJson(json.decode(str));

class SurgeonDetailEntity {
  String? method;
  String? message;
  SurgeonDetail surgeonDetail;

  SurgeonDetailEntity({
    this.method,
    this.message,
    required this.surgeonDetail,
  });
  factory SurgeonDetailEntity.fromJson(Map<String, dynamic> json) => SurgeonDetailEntity(
        message: json["message"],
        method: json["method"],
        surgeonDetail: SurgeonDetail.fromJson(json["values"]),
      );
}

class SurgeonDetail {
  String? id;
  String? firstName;
  String? midName;
  String? lastName;
  String? suffix;
  String? credentials;
  String? specialty;
  String? cellNumber;
  String? email;
  String? photo;
  String? spouse;
  String? familyNotes;
  String? birthday;
  String? notes;
  String? assistant;
  String? website;
  String? hcpid;
  String? createDate;
  Training? training;

  SurgeonDetail({
    this.id,
    this.firstName,
    this.midName,
    this.lastName,
    this.suffix,
    this.credentials,
    this.specialty,
    this.cellNumber,
    this.email,
    this.photo,
    this.spouse,
    this.familyNotes,
    this.birthday,
    this.notes,
    this.assistant,
    this.website,
    this.hcpid,
    this.createDate,
    this.training,
  });

  String? fullName() => "$firstName $lastName".trim();

  factory SurgeonDetail.fromJson(Map<String, dynamic> json) => SurgeonDetail(
      id: json['id'],
      firstName: json['firstName'],
      midName: json['midName'],
      lastName: json['lastName'],
      suffix: json['suffix'],
      credentials: json['credentials'],
      specialty: json['specialty'],
      cellNumber: json['cellNumber'],
      email: json['email'],
      photo: json['photo'],
      spouse: json['spouse'],
      familyNotes: json['familyNotes'],
      birthday: json['birthday'],
      notes: json['notes'],
      assistant: json['assistant'],
      website: json['website'],
      hcpid: json['hcpid'],
      createDate: json['createDate'],
      training: json['training'] != null ? Training.fromJson(json['training']) : null);
}

class Training {
  String? surgeonId;
  String? unGradId;
  String? unGradStartYear;
  String? unGradEndYear;
  String? medSchId;
  String? medSchStartYear;
  String? medSchEndYear;
  String? residencyId;
  String? residencyStartYear;
  String? residencyEndYear;
  String? fellowshipId;
  String? fellowshipStartYear;
  String? fellowshipEndYear;
  String? trainingNotes;
  String? unGradName;
  String? medSchName;
  String? residencyName;
  String? fellowshipName;

  Training(
      {this.surgeonId,
      this.unGradId,
      this.unGradStartYear,
      this.unGradEndYear,
      this.medSchId,
      this.medSchStartYear,
      this.medSchEndYear,
      this.residencyId,
      this.residencyStartYear,
      this.residencyEndYear,
      this.fellowshipId,
      this.fellowshipStartYear,
      this.fellowshipEndYear,
      this.trainingNotes,
      this.unGradName,
      this.medSchName,
      this.residencyName,
      this.fellowshipName});

  factory Training.fromJson(Map<String, dynamic> json) => Training(
        surgeonId: json['surgeonId'],
        unGradId: json['unGradId'],
        unGradStartYear: json['unGradStartYear'],
        unGradEndYear: json['unGradEndYear'],
        medSchId: json['medSchId'],
        medSchStartYear: json['medSchStartYear'],
        medSchEndYear: json['medSchEndYear'],
        residencyId: json['residencyId'],
        residencyStartYear: json['residencyStartYear'],
        residencyEndYear: json['residencyEndYear'],
        fellowshipId: json['fellowshipId'],
        fellowshipStartYear: json['fellowshipStartYear'],
        fellowshipEndYear: json['fellowshipEndYear'],
        trainingNotes: json['trainingNotes'],
        unGradName: json['unGradName'],
        medSchName: json['medSchName'],
        residencyName: json['residencyName'],
        fellowshipName: json['fellowshipName'],
      );
}
