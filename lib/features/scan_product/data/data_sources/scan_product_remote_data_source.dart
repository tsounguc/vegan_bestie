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
    try {
      final response = await _client.get(
        Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$barcode'),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw FetchProductException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final data = jsonDecode(response.body) as DataMap;
      final foodProduct = FoodProductModel.fromMap(data['product'] as DataMap);
      return foodProduct;
    } on FetchProductException {
      rethrow;
    } catch (e) {
      throw FetchProductException(message: e.toString(), statusCode: 500);
    }
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
}
