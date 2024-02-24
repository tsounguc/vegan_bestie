import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/services/barcode_scanner_plugin.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/data/models/food_product_model.dart';

abstract class ScanProductRemoteDataSource {
  Future<BarcodeModel> scanBarcode();

  Future<FoodProductModel> fetchProduct({required String barcode});
}

class ScanProductRemoteDataSourceImpl implements ScanProductRemoteDataSource {
  const ScanProductRemoteDataSourceImpl(this._scanner, this._client);

  final BarcodeScannerService _scanner;
  final Client _client;

  @override
  Future<FoodProductModel> fetchProduct({required String barcode}) async {
    // TODO: implement fetchProduct
    throw UnimplementedError();
  }

  @override
  Future<BarcodeModel> scanBarcode() async {
    final result = await _scanner.scanBarcode();
    final barcode = BarcodeModel(barcode: result);
    return barcode;
  }
}