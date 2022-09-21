// To parse this JSON data, do
//
//     final productInfoModel = productInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:sheveegan/data/models/product_info_model.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  String? code;
  Product? product;
  int? status;
  String? statusVerbose;
  ScanModel({
    required this.code,
    required this.product,
    required this.status,
    required this.statusVerbose,
  });

  factory ScanModel.fromJson(Map<String, dynamic>? json) => ScanModel(
        code: json?["code"],
        product: Product.fromJson(json?["product"]),
        status: json?["status"],
        statusVerbose: json?["status_verbose"],
      );

  Map<String, dynamic> toJson() => {
        "code": code!,
        "product": product!.toJson(),
        "status": status!,
        "status_verbose": statusVerbose!,
      };
}
