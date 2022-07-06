import 'dart:convert';

import 'package:http/http.dart';
import 'package:sheveegan/model/product_info_model.dart';

class OpenFoodFactsApiProvider {
  Client client = Client();
  final apikey = "";
  // final _baseUrl = "https://world.openfoodfacts.org/api/v2/product/0889392010145";
  final _baseUrl = "https://world.openfoodfacts.org";

  Future<ProductInfoModel>fetchProduct(String barcode) async {
    final response = await client.get(Uri.parse("$_baseUrl/api/v2/product/$barcode"));
    if(response.statusCode == 200){
      print(response.body);
      return ProductInfoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}