import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenFoodFactsApiProvider {
  // final apikey = "";
  // final _baseUrl = "https://world.openfoodfacts.org/api/v2/product/0889392010145";
  final _baseUrl = "https://world.openfoodfacts.org";

  Future<http.Response>fetchProductInfo(String barcode) async {
    // http.Response response;
    try{
      return await http.get(Uri.parse("$_baseUrl/api/v2/product/$barcode"));
      // print(response.body);
    }catch(e){
      throw Exception(e);

    }

  }
}