import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/scan_product/domain/repositories_contracts/scanning_repository.dart';

class ScanBarcode extends UseCase<Barcode> {
  const ScanBarcode(this._repository);

  final ScanProductRepository _repository;

  @override
  ResultFuture<Barcode> call() async => _repository.scanBarcode();
}
