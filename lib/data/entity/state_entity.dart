import 'dart:convert';

StateEntity stateEntityFromJson(String str) => StateEntity.fromJson(json.decode(str));

class StateEntity {
  final String message;
  final String method;
  final List<StatesList> states;

  StateEntity({
    required this.message,
    required this.method,
    required this.states,
  });

  factory StateEntity.fromJson(Map<String, dynamic> json) => StateEntity(
        message: json["message"],
        method: json["method"],
        states: json["values"] == null
            ? []
            : List<StatesList>.from(json["values"].map((x) => StatesList.fromJson(x))),
      );
}

class StatesList {
  final String name;

  StatesList({
    required this.name,
  });

  factory StatesList.fromRawJson(String str) => StatesList.fromJson(json.decode(str));

  factory StatesList.fromJson(Map<String, dynamic> json) => StatesList(
        name: json["name"],
      );
}
