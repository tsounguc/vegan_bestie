import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/repositories/scan_product_repository.dart';

class FetchSavedProductsList extends UseCaseWithParams<List<FoodProduct>, List<String>> {
  const FetchSavedProductsList(this._repository);

  final ScanProductRepository _repository;

  @override
  ResultFuture<List<FoodProduct>> call(List<String> params) async => _repository.fetchSavedProductsList(
        productsList: params,
      );
}
