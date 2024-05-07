import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/enums/update_food_product.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class UpdateFoodProduct extends UseCaseWithParams<void, UpdateFoodProductParams> {
  const UpdateFoodProduct(this._repository);

  final FoodProductRepository _repository;

  @override
  ResultVoid call(UpdateFoodProductParams params) async => _repository.updateFoodProduct(
        action: params.action,
        foodData: params.foodData,
        foodProduct: params.foodProduct,
      );
}

class UpdateFoodProductParams extends Equatable {
  const UpdateFoodProductParams({
    required this.action,
    required this.foodData,
    required this.foodProduct,
  });

  final UpdateFoodAction action;
  final dynamic foodData;
  final FoodProduct foodProduct;

  @override
  List<Object?> get props => [action, foodData, foodProduct];
}
