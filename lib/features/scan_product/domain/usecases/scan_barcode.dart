import 'package:dartz/dartz.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/usecase/usecase.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/repositories_contracts/scanning_repository.dart';

class ScanBarcode extends UseCase<Barcode> {
  const ScanBarcode(this._repository);

  final ScanProductRepository _repository;

  @override
  ResultFuture<Barcode> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

// @override
// ResultFuture<BarcodeEntity> call() => _repository.scanBarcode();
}
