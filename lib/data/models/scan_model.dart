// To parse this JSON data, do
//
//     final productInfoModel = productInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:sheveegan/features/scan_product/data/models/product_info_model.dart';

ScanModel scanModelFromJson(Map<String, dynamic> jsonBody) => ScanModel.fromJson(jsonBody);

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  String? code;
  ProductInfoModel? product;
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
        product: ProductInfoModel.fromJson(json?["product"]),
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
