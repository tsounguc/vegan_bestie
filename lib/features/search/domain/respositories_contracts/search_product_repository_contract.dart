import 'package:dartz/dartz.dart';

import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/search/domain/entities/search_product_entity.dart';

abstract class SearchProductRepositoryContract {
  Future<Either<SearchProductFailure, List<SearchProductEntity>>> searchProduct(String query);
}
