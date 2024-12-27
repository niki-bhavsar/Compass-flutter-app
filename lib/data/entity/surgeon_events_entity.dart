import 'dart:convert';

SurgeonEventsEntity surgeonEventsEntityFromJson(String str) =>
    SurgeonEventsEntity.fromJson(json.decode(str));

class SurgeonEventsEntity {
  final String message;
  final String method;
  final List<SurgeonEvent> futureEvents;
  final List<SurgeonEvent> pastEvents;

  SurgeonEventsEntity({
    required this.message,
    required this.method,
    required this.futureEvents,
    required this.pastEvents,
  });

  factory SurgeonEventsEntity.fromJson(Map<String, dynamic> json) => SurgeonEventsEntity(
        message: json["message"],
        method: json["method"],
        futureEvents: json["values"]["future_events"] == null
            ? []
            : List<SurgeonEvent>.from(
                json["values"]["future_events"].map((x) => SurgeonEvent.fromJson(x))),
        pastEvents: json["values"]["past_events"] == null
            ? []
            : List<SurgeonEvent>.from(
                json["values"]["past_events"].map((x) => SurgeonEvent.fromJson(x))),
      );
}

class SurgeonEvent {
  String? eventId;
  String? eventName;
  String? eventType;
  String? eventStartDate;
  String? eventEndDate;
  String? eventLocation;
  String? eventCity;
  String? eventState;
  String? eventZip;

  SurgeonEvent(
      {this.eventId,
      this.eventName,
      this.eventType,
      this.eventStartDate,
      this.eventEndDate,
      this.eventLocation,
      this.eventCity,
      this.eventState,
      this.eventZip});

  String? fullAddress() => "$eventLocation, $eventCity, $eventState-$eventZip".trim();

  factory SurgeonEvent.fromJson(Map<String, dynamic> json) => SurgeonEvent(
        eventId: json['event_id'],
        eventName: json['event_name'],
        eventType: json['event_type'],
        eventStartDate: json['event_startdate'],
        eventEndDate: json['event_enddate'],
        eventLocation: json['event_location'],
        eventCity: json['event_city'],
        eventState: json['event_state'],
        eventZip: json['event_zip'],
      );
}
