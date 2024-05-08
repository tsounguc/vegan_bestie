import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/enums/update_food_product.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_food_product.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_food_product.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/add_food_product.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/fetch_saved_products_list.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/read_ingredients_from_image.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/scan_barcode.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/update_food_product.dart';

part 'food_product_state.dart';

class FoodProductCubit extends Cubit<FoodProductState> {
  FoodProductCubit({
    required ScanBarcode scanBarcode,
    required FetchProduct fetchProduct,
    required SaveFoodProduct saveFoodProduct,
    required RemoveFoodProduct removeFoodProduct,
    required FetchSavedProductsList fetchSavedProductsList,
    required ReadIngredientsFromImage readIngredientsFromImage,
    required UpdateFoodProduct updateFoodProduct,
    required AddFoodProduct addFoodProduct,
  })  : _scanBarcode = scanBarcode,
        _fetchProduct = fetchProduct,
        _saveFoodProduct = saveFoodProduct,
        _removeFoodProduct = removeFoodProduct,
        _fetchSavedProductsList = fetchSavedProductsList,
        _readIngredientsFromImage = readIngredientsFromImage,
        _updateFoodProduct = updateFoodProduct,
        _addFoodProduct = addFoodProduct,
        super(const ScanProductInitial());
  final ScanBarcode _scanBarcode;
  final FetchProduct _fetchProduct;
  final SaveFoodProduct _saveFoodProduct;
  final RemoveFoodProduct _removeFoodProduct;
  final FetchSavedProductsList _fetchSavedProductsList;
  final ReadIngredientsFromImage _readIngredientsFromImage;
  final UpdateFoodProduct _updateFoodProduct;
  final AddFoodProduct _addFoodProduct;

  Future<void> scanBarcode() async {
    emit(const ScanningBarcode());
    final result = await _scanBarcode();
    result.fold(
      (failure) => emit(FoodProductError(message: failure.message)),
      (success) => emit(BarcodeFound(barcode: success.barcode)),
    );
  }

  Future<void> fetchProduct({required String barcode}) async {
    emit(const FetchingProduct());
    final result = await _fetchProduct(FetchProductParams(barcode: barcode));

    result.fold(
      (failure) {
        if (failure.message == Strings.productNotFound) {
          emit(ProductNotFound(barcode: barcode));
        } else {
          emit(FoodProductError(message: failure.message));
        }
      },
      (product) {
        if (product.productName.isEmpty) {
          emit(ProductNotFound(barcode: product.code));
        } else {
          emit(
            ProductFound(
              product: product,
            ),
          );
        }
      },
    );
  }

  Future<void> addFoodProduct({
    required FoodProduct foodProduct,
    required File productImage,
  }) async {
    emit(const UploadingFoodProduct());
    final result = await _addFoodProduct(
      AddFoodProductParams(
        foodProduct: foodProduct,
        productImage: productImage,
      ),
    );

    result.fold(
      (failure) => emit(FoodProductError(message: failure.message)),
      (success) => emit(const FoodProductUploaded()),
    );
  }

  Future<void> updateFoodProduct({
    required UpdateFoodAction action,
    required FoodProduct foodProduct,
    dynamic foodData,
  }) async {
    emit(const UploadingFoodProduct());
    final result = await _updateFoodProduct(
      UpdateFoodProductParams(
        action: action,
        foodData: foodData,
        foodProduct: foodProduct,
      ),
    );

    result.fold(
      (failure) => emit(FoodProductError(message: failure.message)),
      (success) => emit(const FoodProductUploaded()),
    );
  }

  Future<void> saveFoodProductHandler({required FoodProduct product}) async {
    emit(const SavingFoodProduct());

    final result = await _saveFoodProduct(product.code);

    result.fold((failure) => emit(FoodProductError(message: failure.message)), (success) {
      if (product.productName.isEmpty) {
        emit(ProductNotFound(barcode: product.code));
      } else {
        emit(
          ProductFound(
            product: product,
          ),
        );
      }
    });
  }

  Future<void> removeFoodProductHandler({required FoodProduct product}) async {
    emit(const RemovingFoodProduct());

    final result = await _removeFoodProduct(product.code);

    result.fold(
      (failure) => emit(FoodProductError(message: failure.message)),
      (success) {
        if (product.productName.isEmpty) {
          emit(ProductNotFound(barcode: product.code));
        } else {
          emit(ProductFound(product: product));
        }
      },
    );
  }

  Future<void> fetchProductsList(List<String> savedBarcodesList) async {
    emit(const FetchingProductsList());
    final result = await _fetchSavedProductsList(savedBarcodesList);
    result.fold(
      (failure) => emit(
        FoodProductError(message: failure.message),
      ),
      (savedProductsList) {
        emit(SavedProductsListFetched(savedProductsList: savedProductsList));
      },
    );
  }

  Future<void> readIngredientsFromImage(File pickedIngredientsImage) async {
    emit(const ReadingIngredients());
    final result = await _readIngredientsFromImage(pickedIngredientsImage);
    result.fold(
      (failure) => emit(FoodProductError(message: failure.message)),
      (ingredients) => emit(IngredientsRead(ingredients: ingredients)),
    );
  }
}
