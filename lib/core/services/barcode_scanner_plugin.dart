import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';

abstract class BarcodeScannerServiceContract {
  Future<String> scanBarcode();
}

class BarcodeScannerServiceImpl implements BarcodeScannerServiceContract {
  @override
  Future<String> scanBarcode() async {
    try {
      String barcodeString = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        'Cancel',
        true,
        ScanMode.DEFAULT,
      );
      debugPrint("Barcode: $barcodeString");
      if (int.tryParse(barcodeString) == null || barcodeString.length < 12 || barcodeString.length > 13) {
        debugPrint("Invalid Barcode");
        throw InvalidBarcodeException(message: "Invalid Barcode");
      }

      return barcodeString;
    } on InvalidBarcodeException catch (e) {
      throw InvalidBarcodeException(message: "Invalid Barcode");
    } catch (e) {
      debugPrint("Barcode Scanner Plugin Error Message: " + e.toString());

      throw Exception(e.toString());
    }
  }
}
