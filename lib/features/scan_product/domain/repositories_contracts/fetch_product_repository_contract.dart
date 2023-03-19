import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/scan_product_entity.dart';

abstract class FetchProductRepositoryContract {
  Future<Either<FetchProductFailure, ScanProductEntity>> fetchProduct(String barcode);
}
