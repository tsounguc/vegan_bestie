import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'barcode_scanner_state.dart';

class BarcodeScannerCubit extends Cubit<BarcodeScannerState> {

  BarcodeScannerCubit() : super(InitialScannerState());

  void scanBarcode() async {
    // emit the scanning state
    emit(ScanningBarcodeState());
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', true, ScanMode.BARCODE);
      // .then((barcode) {
      if (barcode.isEmpty || barcode == "-1") {
        emit(ScanningCancelledState(barcode: barcode, message: "Cancelled"));
      } else if (barcode.isNotEmpty) {
        // print("Barcode found: $barcode");
        emit(BarcodeFoundState(barcode: barcode));
      }
      // });
    }on PlatformException catch(e) {
      debugPrint("Platform Error: ${e.message}");

    }
  }
}
