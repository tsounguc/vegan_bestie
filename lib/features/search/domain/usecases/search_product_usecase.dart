import 'package:dartz/dartz.dart';

import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/search/domain/entities/search_product_entity.dart';
import 'package:sheveegan/features/search/domain/respositories_contracts/search_product_repository_contract.dart';

class SearchProductUseCase {
  final SearchProductRepositoryContract _searchProudctRepositoryContract =
      serviceLocator<SearchProductRepositoryContract>();

  Future<Either<SearchProductFailure, List<SearchProductEntity>>> searchProduct(String query) {
    return _searchProudctRepositoryContract.searchProduct(query);
  }
}
