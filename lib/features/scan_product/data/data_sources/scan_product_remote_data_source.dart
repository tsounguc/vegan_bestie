import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/barcode_scanner_plugin.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/data/models/food_product_model.dart';

abstract class ScanProductRemoteDataSource {
  Future<BarcodeModel> scanBarcode();

  Future<FoodProductModel> fetchProduct({required String barcode});
}

const kFetchProductEndPoint = '/api/v2/product/';

class ScanProductRemoteDataSourceImpl implements ScanProductRemoteDataSource {
  const ScanProductRemoteDataSourceImpl(this._scanner, this._client);

  final BarcodeScannerService _scanner;
  final Client _client;

  @override
  Future<FoodProductModel> fetchProduct({required String barcode}) async {
    final response = await _client.get(
      Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$barcode'),
    );

    final data = jsonDecode(response.body) as DataMap;
    debugPrint(data.toString());
    final foodProduct = FoodProductModel.fromMap(data['product'] as DataMap);
    return foodProduct;

    // Response response = await _client.get(Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint/barcode'));
    // if (response.statusCode == 200) {
    //   return json.decode(response.body) as Map<String, dynamic>;
    // } else {
    //   debugPrint("Open Food Facts Status code : ${response.statusCode} \n${response.reasonPhrase}");
    //   throw Exception("Status code : ${response.statusCode} \n${response.reasonPhrase}");
    // }
  }

  @override
  Future<BarcodeModel> scanBarcode() async {
    try {
      final result = await _scanner.scanBarcode();
      final barcode = BarcodeModel(barcode: result);
      return barcode;
    } on ScanException {
      rethrow;
    } catch (e) {
      throw ScanException(message: e.toString());
    }
  }

// Future<Map<String, dynamic>> searchProduct({required String query}) async {
//   String url =
//       "$_baseUrl/cgi/search.pl?search_terms=${query.replaceAll(" ", "%20")}&sort_by=unique_scans_n&json=1";
//   // debugPrint("Search URL: $url");
//
//   http.Response response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     return json.decode(response.body) as Map<String, dynamic>;
//   } else {
//     throw Exception("Status code: ${response.body}");
//   }
// }
}
