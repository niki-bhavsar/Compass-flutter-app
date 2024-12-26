// To parse this JSON data, do
//
//     final templateImplantInstrumentEntity = templateImplantInstrumentEntityFromJson(jsonString);

import 'dart:convert';

TemplateImplantInstrumentEntity templateImplantInstrumentEntityFromJson(String str) =>
    TemplateImplantInstrumentEntity.fromJson(json.decode(str));

class TemplateImplantInstrumentEntity {
  TemplateAllEntity? values;

  TemplateImplantInstrumentEntity({
    this.values,
  });

  factory TemplateImplantInstrumentEntity.fromJson(Map<String, dynamic> json) =>
      TemplateImplantInstrumentEntity(
        values: json["values"] == null ? null : TemplateAllEntity.fromJson(json["values"]),
      );
}

class TemplateAllEntity {
  Quickview? quickview;
  List<TemplatesFilterList>? filterList;
  ImplantInstrumentEntity? allKits;

  TemplateAllEntity({
    this.quickview,
    this.filterList,
    this.allKits,
  });

  factory TemplateAllEntity.fromJson(Map<String, dynamic> json) => TemplateAllEntity(
        quickview: json["quickview"] == null ? null : Quickview.fromJson(json["quickview"]),
        filterList: json["filter_list"] == null
            ? []
            : List<TemplatesFilterList>.from(
                json["filter_list"]!.map((x) => TemplatesFilterList.fromJson(x))),
        allKits:
            json["all_kits"] == null ? null : ImplantInstrumentEntity.fromJson(json["all_kits"]),
      );
}

class ImplantInstrumentEntity {
  List<ImplantEntity>? implants;
  List<ImplantEntity>? instruments;

  ImplantInstrumentEntity({
    this.implants,
    this.instruments,
  });

  factory ImplantInstrumentEntity.fromJson(Map<String, dynamic> json) => ImplantInstrumentEntity(
        implants: json["implants"] == null
            ? []
            : List<ImplantEntity>.from(json["implants"]!.map((x) => ImplantEntity.fromJson(x))),
        instruments: json["instruments"] == null
            ? []
            : List<ImplantEntity>.from(json["instruments"]!.map((x) => ImplantEntity.fromJson(x))),
      );
}

class ImplantEntity {
  String manufacturerId;
  String manufacturerName;
  List<ImplantCategory> values;

  ImplantEntity({
    required this.manufacturerId,
    required this.manufacturerName,
    required this.values,
  });

  bool isEmpty() {
    return values.isEmpty;
  }

  factory ImplantEntity.fromJson(Map<String, dynamic> json) {
    Map<String, ImplantCategory> categories = {};

    if (json["values"] != null) {
      var list = List<ImplantValue>.from(json["values"]!.map((x) => ImplantValue.fromJson(x)));

      List<ImplantValue>? implantList;
      for (var implant in list) {
        if (implant.header) {
          final category = categories[implant.id ?? ""];
          if (category == null) {
            implantList = [];
            categories[implant.id ?? ""] =
                ImplantCategory(name: implant.name ?? "", list: implantList);
          } else {
            implantList = category.list;
          }
        } else {
          implantList?.add(implant);
        }
      }
    }

    return ImplantEntity(
      manufacturerId: json["manufacturer_id"] ?? "",
      manufacturerName: json["manufacturer_name"] ?? "",
      values: categories.values.toList(),
    );
  }
}

class ImplantCategory {
  final String name;
  final List<ImplantValue> list;

  ImplantCategory({
    required this.name,
    required this.list,
  });
}

class ImplantValue {
  String? id;
  String? name;
  bool header;
  bool selected;
  int? quantity;
  String? description;
  String? systemId;
  String? assignedQuantity;

  ImplantValue({
    this.id,
    this.name,
    required this.header,
    required this.selected,
    this.quantity,
    this.description,
    this.systemId,
    this.assignedQuantity,
  });

  factory ImplantValue.fromJson(Map<String, dynamic> json) => ImplantValue(
        id: json["id"],
        name: json["name"],
        header: json["header"] ?? false,
        selected: json["selected"] ?? false,
        quantity: json["quantity"],
        description: json["description"],
        systemId: json["system_id"],
        assignedQuantity: json["assigned_quantity"],
      );
}

class TemplatesFilterList {
  String? id;
  String? name;
  int? isHeader;
  String? color;
  List<FilterListValue>? values;

  TemplatesFilterList({
    this.id,
    this.name,
    this.isHeader,
    this.color,
    this.values,
  });

  factory TemplatesFilterList.fromJson(Map<String, dynamic> json) => TemplatesFilterList(
        id: json["id"]?.toString(),
        name: json["name"],
        isHeader: json["isHeader"],
        color: json["color"],
        values: json["values"] == null
            ? []
            : List<FilterListValue>.from(json["values"]!.map((x) => FilterListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isHeader": isHeader,
        "color": color,
        "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class FilterListValue {
  String? id;
  String? title;
  int? isHeader;
  String? subHeaderId;

  FilterListValue({
    this.id,
    this.title,
    this.isHeader,
    this.subHeaderId,
  });

  factory FilterListValue.fromJson(Map<String, dynamic> json) => FilterListValue(
        id: json["id"],
        title: json["title"],
        isHeader: json["isHeader"],
        subHeaderId: json["subHeaderId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "isHeader": isHeader,
        "subHeaderId": subHeaderId,
      };
}

class Quickview {
  List<String>? quickviewSequence;
  ImplantInstrumentEntity? selected;
  List<dynamic>? all;
  List<dynamic>? company;
  List<Template>? template;

  Quickview({
    this.quickviewSequence,
    this.selected,
    this.all,
    this.company,
    this.template,
  });

  factory Quickview.fromJson(Map<String, dynamic> json) => Quickview(
        quickviewSequence: json["quickviewSequence"] == null
            ? []
            : List<String>.from(json["quickviewSequence"]!.map((x) => x)),
        selected:
            json["selected"] == null ? null : ImplantInstrumentEntity.fromJson(json["selected"]),
        all: json["all"] == null ? [] : List<dynamic>.from(json["all"]!.map((x) => x)),
        company: json["company"] == null ? [] : List<dynamic>.from(json["company"]!.map((x) => x)),
        template: json["template"] == null
            ? []
            : List<Template>.from(json["template"]!.map((x) => Template.fromJson(x))),
      );
}

class Template {
  String? id;
  String? name;

  Template({
    this.id,
    this.name,
  });

  factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

ImplantInstrumentEditTemplateEntity implantInstrumentEditTemplateEntity(String str) =>
    ImplantInstrumentEditTemplateEntity.fromJson(json.decode(str));

class ImplantInstrumentEditTemplateEntity {
  ImplantInstrumentEntity? values;

  ImplantInstrumentEditTemplateEntity({
    this.values,
  });

  factory ImplantInstrumentEditTemplateEntity.fromJson(Map<String, dynamic> json) =>
      ImplantInstrumentEditTemplateEntity(
        values: json["values"] == null ? null : ImplantInstrumentEntity.fromJson(json["values"]),
      );
}
