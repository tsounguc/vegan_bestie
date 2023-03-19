import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../entities/search_product_entity.dart';

abstract class SearchProductRepositoryContract {
  Future<Either<SearchProductFailure, List<SearchProductEntity>>> searchProduct(String query);
}
