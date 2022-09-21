import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OpenFoodFactsApiProvider {
  // final apikey = "";
  // final _baseUrl = "https://world.openfoodfacts.org/api/v2/product/0889392010145";
  final _baseUrl = "https://us.openfoodfacts.org";

  Future<http.Response>fetchProductInfo(String barcode) async {
    // http.Response response;
    try{
      return await http.get(Uri.parse("$_baseUrl/api/v2/product/$barcode"));
      // print(response.body);
    }catch(e){
      throw Exception(e);

    }

  }

  Future<http.Response>searchProductInfo(String query) async{
    String url = "$_baseUrl/cgi/search.pl?search_terms=${query.replaceAll(" ", "%20")}&sort_by=unique_scans_n&json=1";
    debugPrint("Search URL: $url");
    try{
      return await http.get(Uri.parse(url));
    }catch(e){
      throw Exception(e);

    }
  }
}