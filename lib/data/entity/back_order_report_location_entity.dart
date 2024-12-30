import 'dart:convert';

import '../../utils/intl_utils.dart';

BackorderReportLocationEntity backorderReportLocationEntityFromJson(String str) =>
    BackorderReportLocationEntity.fromJson(json.decode(str));

class BackorderReportLocationEntity {
  String? method;
  String? message;
  List<Location> locations;

  BackorderReportLocationEntity({
    this.method,
    this.message,
    required this.locations,
  });

  factory BackorderReportLocationEntity.fromJson(Map<String, dynamic> json) =>
      BackorderReportLocationEntity(
        method: json['method'],
        message: json['message'],
        locations: json["values"] == null
            ? []
            : List<Location>.from(
                json["values"].map((x) => Location.fromJson(x)),
              ),
      );
}

class Location {
  String? location;
  String? partNumber;
  String? partDescription;
  String? totalProductNumber;
  List<LocationData>? locationData;

  Location({
    this.location,
    this.partNumber,
    this.partDescription,
    this.totalProductNumber,
    this.locationData,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        location: json['location'],
        partNumber: json['part_number'],
        partDescription: json['part_description'],
        totalProductNumber: json['totalProductNumber'],
        locationData: json["location_data"] == null
            ? []
            : List<LocationData>.from(
                json["location_data"].map((x) => LocationData.fromJson(x)),
              ),
      );
}

class LocationData {
  String? partNumber;
  String? partDescription;
  String? openQty;
  DateTime? orderCreationDate;
  String? slsOrder;
  String? puOrderNo;
  String? daysOnBackorder;

  LocationData({
    this.partNumber,
    this.partDescription,
    this.openQty,
    this.orderCreationDate,
    this.slsOrder,
    this.puOrderNo,
    this.daysOnBackorder,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        partNumber: json['part_number'],
        partDescription: json['part_description'],
        openQty: json['open_qty'],
        orderCreationDate: IntlUtil.parseDate(json["order_creation_date"]),
        slsOrder: json['sls_order'],
        puOrderNo: json['pu_order_no'],
        daysOnBackorder: json['days_on_backorder'],
      );
}
