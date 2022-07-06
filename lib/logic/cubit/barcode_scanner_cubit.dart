import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'barcode_scanner_state.dart';

class BarcodeScannerCubit extends Cubit<BarcodeScannerState> {
  BarcodeScannerCubit() : super(InitialScannerState());

  void scanBarcode() async {
    // emit the scanning state
    emit(ScanningBarcodeState());
    await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', true, ScanMode.BARCODE).then((barcode) {
      if (barcode.isEmpty || barcode == "-1") {
        emit(ScanningCancelled(barcode: barcode,message:"Cancelled"));
      }else if(barcode.isNotEmpty) {
        emit(BarcodeFoundState(barcode: barcode));
      }
    });
  }
}
