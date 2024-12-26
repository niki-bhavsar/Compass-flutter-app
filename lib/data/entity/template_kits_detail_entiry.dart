// To parse this JSON data, do
//
//     final kitsDetail = kitsDetailFromJson(jsonString);

import 'dart:convert';

TemplateKitsDetailEntiry kitsDetailFromJson(String str) =>
    TemplateKitsDetailEntiry.fromJson(json.decode(str));

String kitsDetailToJson(TemplateKitsDetailEntiry data) => json.encode(data.toJson());

class TemplateKitsDetailEntiry {
  KitsDetail? values;

  TemplateKitsDetailEntiry({
    this.values,
  });

  factory TemplateKitsDetailEntiry.fromJson(Map<String, dynamic> json) => TemplateKitsDetailEntiry(
        values: json["values"] == null ? null : KitsDetail.fromJson(json["values"]),
      );

  Map<String, dynamic> toJson() => {
        "values": values?.toJson(),
      };
}

class KitsDetail {
  List<InventoryItem>? inventoryItems;
  List<dynamic>? kitImages;

  KitsDetail({
    this.inventoryItems,
    this.kitImages,
  });

  factory KitsDetail.fromJson(Map<String, dynamic> json) => KitsDetail(
        inventoryItems: json["inventory_items"] == null
            ? []
            : List<InventoryItem>.from(
                json["inventory_items"]!.map((x) => InventoryItem.fromJson(x))),
        kitImages:
            json["kit_images"] == null ? [] : List<dynamic>.from(json["kit_images"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "inventory_items": inventoryItems == null
            ? []
            : List<dynamic>.from(inventoryItems!.map((x) => x.toJson())),
        "kit_images": kitImages == null ? [] : List<dynamic>.from(kitImages!.map((x) => x)),
      };
}

class InventoryItem {
  String? quantity;
  String? number;
  String? description;

  InventoryItem({
    this.quantity,
    this.number,
    this.description,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        quantity: json["quantity"],
        number: json["number"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "number": number,
        "description": description,
      };
}
