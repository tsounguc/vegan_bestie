import 'package:dartz/dartz.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/service_locator.dart';

import '../entities/barcode_entity.dart';
import '../repositories_contracts/scan_barcode_repository_contract.dart';

class ScanBarcodeUseCase {
  final ScanBarcodeRepositoryContract _barcodeRepositoryContract = serviceLocator<ScanBarcodeRepositoryContract>();
  Future<Either<ScanningFailure, BarcodeEntity>> scanBarcode() {
    return _barcodeRepositoryContract.scanBarcode();
  }
}
