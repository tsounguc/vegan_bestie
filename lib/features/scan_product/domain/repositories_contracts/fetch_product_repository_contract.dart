import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/product_info_entity.dart';

abstract class FetchProductRepositoryContract {
  Future<Either<FetchProductFailure, ProductInfoEntity>> fetchProduct(String barcode);
}
