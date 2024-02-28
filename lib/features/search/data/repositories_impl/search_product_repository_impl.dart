// import 'package:dartz/dartz.dart';
//
// import '../../../../core/failures_successes/exceptions.dart';
// import '../../../../core/failures_successes/failures.dart';
// import '../../../../core/services/service_locator.dart';
// import '../../domain/entities/search_product_entity.dart';
// import '../../domain/respositories_contracts/search_product_repository_contract.dart';
// import '../data_sources/search_products_from_remote_data_source.dart';
// import '../mappers/search_product_mapper.dart';
// import '../models/search_product_model.dart';
//
// class SearchProductRepositoryImpl implements SearchProductRepositoryContract {
//   final SearchProductsFromRemoteDataSourceContract searchRemoteDataSourceContract =
//       serviceLocator<SearchProductsFromRemoteDataSourceContract>();
//
//   @override
//   Future<Either<SearchProductFailure, List<SearchProductEntity>>> searchProduct(String query) async {
//     try {
//       List<SearchProductModel> searchProductModelsList = await searchRemoteDataSourceContract.searchProduct(query);
//       SearchProductMapper mapper = SearchProductMapper();
//       List<SearchProductEntity> searchProductEntitiesList = [];
//       for (int index = 0; index < searchProductModelsList.length; index++) {
//         SearchProductEntity searchProductEntity = mapper.mapToEntity(searchProductModelsList[index]);
//         searchProductEntitiesList.add(searchProductEntity);
//       }
//       return Right(searchProductEntitiesList);
//     } on SearchProductException catch (e) {
//       return Left(SearchProductFailure(message: e.message));
//     }
//   }
// }
