import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/scan_product_entity.dart';
import '../repositories_contracts/fetch_product_repository_contract.dart';

class FetchProductUseCase {
  final FetchProductRepositoryContract _fetchProductRepositoryContract =
      serviceLocator<FetchProductRepositoryContract>();
  Future<Either<FetchProductFailure, ScanProductEntity>> fetchProduct(String barcode) {
    return _fetchProductRepositoryContract.fetchProduct(barcode);
  }
}
