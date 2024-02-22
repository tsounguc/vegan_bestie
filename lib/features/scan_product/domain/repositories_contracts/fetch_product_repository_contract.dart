import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/scanned_product.dart';

abstract class FetchProductRepositoryContract {
  Future<Either<FetchProductFailure, ScannedProduct>> fetchProduct(String barcode);
}
