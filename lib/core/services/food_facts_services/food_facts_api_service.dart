import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class FoodFactsApiServiceContract {
  Future<Map<String, dynamic>> getProductData({required String barcode});

  Future<Map<String, dynamic>> searchProduct({required String query});
}

class OpenFoodFactsApiServiceImpl implements FoodFactsApiServiceContract {
  // final apikey = "";
  // final _baseUrl = "https://world.openfoodfacts.org/api/v2/product/0889392010145";
  final _baseUrl = "https://us.openfoodfacts.org";

  @override
  Future<Map<String, dynamic>> getProductData({required String barcode}) async {
    http.Response response = await http.get(Uri.parse("$_baseUrl/api/v2/product/$barcode"));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      debugPrint("Open Food Facts Status code : ${response.statusCode} \n${response.reasonPhrase}");
      throw Exception("Status code : ${response.statusCode} \n${response.reasonPhrase}");
    }
  }

  @override
  Future<Map<String, dynamic>> searchProduct({required String query}) async {
    String url =
        "$_baseUrl/cgi/search.pl?search_terms=${query.replaceAll(" ", "%20")}&sort_by=unique_scans_n&json=1";
    // debugPrint("Search URL: $url");

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Status code: ${response.body}");
    }
  }
}
