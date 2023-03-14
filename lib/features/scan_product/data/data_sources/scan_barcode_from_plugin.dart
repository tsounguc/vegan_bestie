import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/core/services/barcode_scanner_plugin.dart';

import '../models/barcode_model.dart';

abstract class ScanBarcodeFromPluginContract {
  Future<BarcodeModel> scanBarcode();
}

class ScanBarcodeFromPluginImpl implements ScanBarcodeFromPluginContract {
  final BarcodeScannerServiceContract barcodeScannerServiceContract =
      serviceLocator<BarcodeScannerServiceContract>();
  @override
  Future<BarcodeModel> scanBarcode() async {
    String barcode = await barcodeScannerServiceContract.scanBarcode();
    return BarcodeModel(barcode: barcode);
  }
}
