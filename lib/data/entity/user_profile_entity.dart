import 'dart:convert';

UserProfileEntity userProfileEntityFromJson(String str) =>
    UserProfileEntity.fromJson(json.decode(str));

class UserProfileEntity {
  final String message;
  final String method;
  final UserProfileInfo userProfileInfo;

  UserProfileEntity({
    required this.message,
    required this.method,
    required this.userProfileInfo,
  });

  factory UserProfileEntity.fromJson(Map<String, dynamic> json) => UserProfileEntity(
        message: json["message"],
        method: json["method"],
        userProfileInfo: UserProfileInfo.fromJson(json["values"]),
      );
}

class UserProfileInfo {
  final String accountNumber;
  final String addressLine1;
  final String addressLine2;
  final String cellNumber;
  final String city;
  final String contactInfo;
  final String email;
  final String faxNumber;
  final String firstName;
  final String group;
  final String lastName;
  final String login;
  final String phoneNumber;
  final String state;
  final String wwId;
  final String zipCode;

  UserProfileInfo({
    required this.accountNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.cellNumber,
    required this.city,
    required this.contactInfo,
    required this.email,
    required this.faxNumber,
    required this.firstName,
    required this.group,
    required this.lastName,
    required this.login,
    required this.phoneNumber,
    required this.state,
    required this.wwId,
    required this.zipCode,
  });

  factory UserProfileInfo.fromRawJson(String str) => UserProfileInfo.fromJson(json.decode(str));

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) => UserProfileInfo(
        accountNumber: json["Account Number"],
        addressLine1: json["Address Line1"],
        addressLine2: json["Address Line2"],
        cellNumber: json["Cell Number"],
        city: json["City"],
        contactInfo: json["Contract Info"],
        email: json["Email"],
        faxNumber: json["Fax Number"],
        firstName: json["First Name"],
        group: json["Group"],
        lastName: json["Last Name"],
        login: json["Login"],
        phoneNumber: json["Phone Number"],
        state: json["State"],
        wwId: json["WWID"],
        zipCode: json["Zipcode"],
      );
}
