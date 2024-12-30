import 'dart:convert';

BackorderReportProductEntity backorderReportProductEntityFromJson(String str) =>
    BackorderReportProductEntity.fromJson(json.decode(str));

class BackorderReportProductEntity {
  String? method;
  String? message;
  List<Product> products;

  BackorderReportProductEntity({
    this.method,
    this.message,
    required this.products,
  });

  factory BackorderReportProductEntity.fromJson(Map<String, dynamic> json) =>
      BackorderReportProductEntity(
        method: json['method'],
        message: json['message'],
        products: json["values"] == null
            ? []
            : List<Product>.from(
                json["values"].map((x) => Product.fromJson(x)),
              ),
      );
}

class Product {
  String? partNumber;
  String? partDescription;
  String? totalQty;
  List<ProductData>? productData;

  Product({
    this.partNumber,
    this.partDescription,
    this.totalQty,
    this.productData,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        partNumber: json['part_number'],
        partDescription: json['part_description'],
        totalQty: json['total_qty'],
        productData: json["product_data"] == null
            ? []
            : List<ProductData>.from(
                json["product_data"].map((x) => ProductData.fromJson(x)),
              ),
      );
}

class ProductData {
  String? shipPartyName;
  String? partNumber;
  String? partDescription;
  String? openQty;

  ProductData({this.shipPartyName, this.partNumber, this.partDescription, this.openQty});

  ProductData.fromJson(Map<String, dynamic> json) {
    shipPartyName = json['ship_party_name'];
    partNumber = json['part_number'];
    partDescription = json['part_description'];
    openQty = json['open_qty'];
  }
}
