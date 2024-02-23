import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/food_facts_services/food_facts_api_service.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/services/barcode_scanner_plugin.dart';

import '../models/barcode_model.dart';
import '../models/food_product_model.dart';

abstract class ScanProductRemoteDataSource {
  Future<BarcodeModel> scanBarcode();

  Future<FoodProductModel> fetchProduct(String barcode);
}

// class ScanBarcodeFromPluginImpl implements ScanProductRemoteDataSource {
//   final BarcodeScannerServiceContract barcodeScannerServiceContract =
//       serviceLocator<BarcodeScannerServiceContract>();
//
//   final FoodFactsApiServiceContract foodFactsApiServiceContract =
//   serviceLocator<FoodFactsApiServiceContract>();
//
//   @override
//   Future<ScanProductModel> fetchProduct(String barcode) async {
//     try {
//       Map<String, dynamic> data = await foodFactsApiServiceContract.getProductData(barcode: barcode);
//       ScanProductModel productInfo = ScanProductModel.fromJson(data['product']);
//       return productInfo;
//     } catch (e) {
//       throw FetchProductException(message: Strings.productNotFound);
//     }
//   }
//
//   @override
//   Future<BarcodeModel> scanBarcode() async {
//     try {
//       String barcode = await barcodeScannerServiceContract.scanBarcode();
//       return BarcodeModel(barcode: barcode);
//     } on InvalidBarcodeException catch (e) {
//       throw ScanBarcodeException(message: e.message);
//     } catch (e) {
//       throw const ScanBarcodeException(message: "Failed to scan barcode");
//     }
//   }
// }
