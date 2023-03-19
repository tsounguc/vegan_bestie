import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

abstract class BarcodeScannerServiceContract {
  Future<String> scanBarcode();
}

class BarcodeScannerServiceImpl implements BarcodeScannerServiceContract {
  @override
  Future<String> scanBarcode() async {
    try {
      return await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        'Cancel',
        true,
        ScanMode.DEFAULT,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
