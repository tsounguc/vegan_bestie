import 'dart:io';

import 'package:sheveegan/core/enums/update_food_product.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';

abstract class FoodProductRepository {
  ResultFuture<Barcode> scanBarcode();

  ResultFuture<FoodProduct> fetchProduct({required String barcode});

  ResultVoid saveFoodProduct({required String barcode});

  ResultVoid removeFoodProduct({required String barcode});

  ResultFuture<List<FoodProduct>> fetchSavedProductsList({required List<String> productsList});

  ResultFuture<String> readIngredientsFromImage({required File image});

  ResultVoid addFoodProduct({required FoodProduct foodProduct, required File productImage});

  ResultVoid updateFoodProduct({
    required FoodProduct foodProduct,
    required dynamic foodData,
    required UpdateFoodAction action,
  });

  ResultVoid reportIssue(FoodProductReport report);

  ResultFuture<List<FoodProductReport>> fetchFoodProductReports();

  ResultVoid deleteReport(FoodProductReport report);
}
