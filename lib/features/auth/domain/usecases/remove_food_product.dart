import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';

class RemoveFoodProduct extends UseCaseWithParams<void, String> {
  const RemoveFoodProduct(this._repository);

  final ScanProductRepository _repository;

  @override
  ResultFuture<void> call(String params) async => _repository.removeFoodProduct(barcode: params);
}
