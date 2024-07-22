import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';

// abstract class BarcodeScannerService {
//   Future<String> scanBarcode();
// }

class BarcodeScannerPlugin {
  Future<String> scanBarcode() async {
    final barcodeString = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.DEFAULT,
    );
    debugPrint('Barcode: $barcodeString');
    if (barcodeString == '-1') {
      throw const ScanException(message: 'Scan Canceled');
    }
    if (int.tryParse(barcodeString) == null || barcodeString.isEmpty
        // ||
        // barcodeString.length < 12 ||
        // barcodeString.length > 13
        ) {
      debugPrint('Invalid Barcode');
      throw const ScanException(message: 'Invalid Barcode');
    }

    return barcodeString;
  }
}
