import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class AddFoodProduct implements UseCaseWithParams<void, AddFoodProductParams> {
  const AddFoodProduct(this._repository);

  final FoodProductRepository _repository;

  @override
  ResultFuture<void> call(AddFoodProductParams params) => _repository.addFoodProduct(
        foodProduct: params.foodProduct,
        productImage: params.productImage,
      );
}

class AddFoodProductParams extends Equatable {
  const AddFoodProductParams({
    required this.foodProduct,
    required this.productImage,
  });

  final FoodProduct foodProduct;
  final File productImage;

  @override
  List<Object?> get props => [foodProduct, productImage];
}
