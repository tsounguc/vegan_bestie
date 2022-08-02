import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sheveegan/data/models/search_model.dart';

import '../models/product_info_model.dart';
import '../models/scan_model.dart';
import '../providers/open_food_facts_api_provider.dart';

class Repository {
  final OpenFoodFactsApiProvider openFoodFactApiProvider;

  const Repository({
    required this.openFoodFactApiProvider,
  });
  Future<ScanModel?> fetchProduct(String barcode) async {
      // print("fetching barcode: $barcode");
      final fetchResponse = await openFoodFactApiProvider.fetchProductInfo(barcode);
      ScanModel productInfo = scanModelFromJson(fetchResponse.body.toString());
      return productInfo;

  }

  Future<SearchModel> searchQuery(String query) async {
    // try {
      final searchResponse = await openFoodFactApiProvider.searchProductInfo(query);
      print(searchResponse.statusCode);
      SearchModel searchModel = searchModelFromJson(searchResponse.body.toString());
      // print("first product ${searchModel.products?[0].productName}");
      return searchModel;
    // }catch(e){
    //   throw Exception(e);
    // }
  }
}
