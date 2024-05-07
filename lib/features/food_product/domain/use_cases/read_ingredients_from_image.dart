import 'dart:io';

import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class ReadIngredientsFromImage extends UseCaseWithParams<String, File> {
  const ReadIngredientsFromImage(this._repository);

  final FoodProductRepository _repository;

  @override
  ResultFuture<String> call(File params) async => _repository.readIngredientsFromImage(image: params);
}
