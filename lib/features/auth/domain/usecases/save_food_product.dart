import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class SaveFoodProduct extends UseCaseWithParams<void, String> {
  const SaveFoodProduct(this._repository);

  final FoodProductRepository _repository;

  @override
  ResultVoid call(String params) async => _repository.saveFoodProduct(barcode: params);
}
