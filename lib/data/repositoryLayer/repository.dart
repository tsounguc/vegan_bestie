import 'dart:io';

import 'package:flutter/material.dart';

import '../models/product_info_model.dart';
import '../providers/open_food_facts_api_provider.dart';

class Repository {
  final OpenFoodFactsApiProvider openFoodFactApiProvider;

  const Repository({
    required this.openFoodFactApiProvider,
  });
  Future<ProductInfoModel?> fetchProduct(String barcode) async {
      // print("fetching barcode: $barcode");
      final fetchResponse = await openFoodFactApiProvider.fetchProductInfo(barcode);
      ProductInfoModel productInfo = productInfoModelFromJson(fetchResponse.body.toString());
      return productInfo;

  }
}
