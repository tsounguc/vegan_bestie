import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode_entity.dart';
import '../../domain/usecases/scan_barcode_usecase.dart';

part 'barcode_scanner_state.dart';

class BarcodeScannerCubit extends Cubit<BarcodeScannerState> {
  final ScanBarcodeUseCase _scanProductUseCase = serviceLocator<ScanBarcodeUseCase>();
  BarcodeScannerCubit() : super(InitialScannerState());

  void scanBarcode() async {
    emit(ScanningBarcodeState());
    final Either<ScanningFailure, BarcodeEntity> scanBarcodeResult = await _scanProductUseCase.scanBarcode();
    scanBarcodeResult.fold(
      (scanningFailure) => emit(ScanningErrorState(error: scanningFailure.message)),
      (barcodeEntity) {
        if (barcodeEntity.barcode!.isEmpty || barcodeEntity.barcode == "-1") {
          emit(ScanningCancelledState(barcode: barcodeEntity.barcode, message: "Cancelled"));
        } else if (barcodeEntity.barcode!.isNotEmpty) {
          print("Barcode found: ${barcodeEntity.barcode}");
          emit(BarcodeFoundState(barcode: barcodeEntity.barcode!));
        }
      },
    );
  }
}
