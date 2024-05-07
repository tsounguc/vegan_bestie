part of 'food_product_cubit.dart';

abstract class FoodProductState extends Equatable {
  const FoodProductState();

  @override
  List<Object> get props => [];
}

class ScanProductInitial extends FoodProductState {
  const ScanProductInitial();
}

class ScanningBarcode extends FoodProductState {
  const ScanningBarcode();
}

class BarcodeFound extends FoodProductState {
  const BarcodeFound({required this.barcode});

  final String barcode;

  @override
  List<Object> get props => [barcode];
}

class FetchingProduct extends FoodProductState {
  const FetchingProduct();
}

class ProductFound extends FoodProductState {
  const ProductFound({
    required this.product,
  });

  final FoodProduct product;

  @override
  List<Object> get props => [
        product,
      ];
}

class SavingFoodProduct extends FoodProductState {
  const SavingFoodProduct();
}

class RemovingFoodProduct extends FoodProductState {
  const RemovingFoodProduct();
}

class FoodProductSaved extends FoodProductState {
  const FoodProductSaved({
    required this.product,
    required this.nonVeganIngredients,
    required this.isVegan,
    required this.isVegetarian,
  });

  final FoodProduct product;
  final bool isVegan;

  final bool isVegetarian;
  final String nonVeganIngredients;
}

class FetchingProductsList extends FoodProductState {
  const FetchingProductsList();
}

class SavedProductsListFetched extends FoodProductState {
  const SavedProductsListFetched({required this.savedProductsList});

  final List<FoodProduct> savedProductsList;
}

class UploadingFoodProduct extends FoodProductState {
  const UploadingFoodProduct();
}

class FoodProductUploaded extends FoodProductState {
  const FoodProductUploaded();
}

class ReadingIngredients extends FoodProductState {
  const ReadingIngredients();
}

class IngredientsRead extends FoodProductState {
  const IngredientsRead({
    required this.ingredients,
  });

  final String ingredients;
}

class ProductNotFound extends FoodProductState {
  const ProductNotFound();
}

class FoodProductError extends FoodProductState {
  const FoodProductError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}