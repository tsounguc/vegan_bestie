// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:sheveegan/data/models/product_info_model.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.count,
    required this.page,
    required this.pageCount,
    required this.pageSize,
    required this.products,
    required this.skip,
  });

  int? count;
  int? page;
  int? pageCount;
  int pageSize;
  List<Product>? products;
  int? skip;

  factory SearchModel.fromJson(Map<String, dynamic>? json) => SearchModel(
    count: json?["count"],
    page: json?["page"],
    pageCount: json?["page_count"],
    pageSize: json?["page_size"],
    products: List<Product>.from(json?["products"].map((x) => Product.fromJson(x))),
    skip: json?["skip"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "page": page,
    "page_count": pageCount,
    "page_size": pageSize,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "skip": skip,
  };
}


