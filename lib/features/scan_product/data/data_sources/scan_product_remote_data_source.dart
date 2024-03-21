import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/barcode_scanner_plugin.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/resources/strings.dart';
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

  final BarcodeScannerPlugin _scanner;
  final Client _client;

  @override
  Future<FoodProductModel> fetchProduct({required String barcode}) async {
    try {
      final response = await _client.get(
        Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$barcode'),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw FetchProductException(
          message: Strings.productNotFound,
          statusCode: response.statusCode,
        );
      }

      final data = jsonDecode(response.body);

      final foodProduct = FoodProductModel.fromMap(data['product'] as DataMap);
      return foodProduct;
    } on FetchProductException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw FetchProductException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<BarcodeModel> scanBarcode() async {
    try {
      final result = await _scanner.scanBarcode();
      final barcode = BarcodeModel(barcode: result);
      return barcode;
    } on ScanException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw ScanException(message: e.toString(), statusCode: 502);
    }
  }
}
