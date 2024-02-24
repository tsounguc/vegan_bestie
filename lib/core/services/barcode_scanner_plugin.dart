import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';

// abstract class BarcodeScannerService {
//   Future<String> scanBarcode();
// }

class BarcodeScannerService {
  Future<String> scanBarcode() async {
    final barcodeString = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.DEFAULT,
    );
    debugPrint('Barcode: $barcodeString');
    if (int.tryParse(barcodeString) == null || barcodeString.length < 12 || barcodeString.length > 13) {
      debugPrint('Invalid Barcode');
      throw const ScanException(message: 'Invalid Barcode');
    }

    return barcodeString;
  }
}
