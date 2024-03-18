import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.main.dart';
import '../entities/search_product_entity.dart';
import '../respositories_contracts/search_product_repository_contract.dart';

class SearchProductUseCase {
  final SearchProductRepositoryContract _searchProudctRepositoryContract =
      serviceLocator<SearchProductRepositoryContract>();

  Future<Either<SearchProductFailure, List<SearchProductEntity>>> searchProduct(String query) {
    return _searchProudctRepositoryContract.searchProduct(query);
  }
}
