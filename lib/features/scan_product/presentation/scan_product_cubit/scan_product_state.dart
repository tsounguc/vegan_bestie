part of 'scan_product_cubit.dart';

abstract class ScanProductState extends Equatable {
  const ScanProductState();

  @override
  List<Object> get props => [];
}

class ScanProductInitial extends ScanProductState {
  const ScanProductInitial();
}

class ScanningBarcode extends ScanProductState {
  const ScanningBarcode();
}

class BarcodeFound extends ScanProductState {
  const BarcodeFound({required this.barcode});

  final String barcode;

  @override
  List<Object> get props => [barcode];
}

class FetchingProduct extends ScanProductState {
  const FetchingProduct();
}

class ProductFound extends ScanProductState {
  const ProductFound({
    required this.product,
  });

  final FoodProduct product;

  @override
  List<Object> get props => [
        product,
      ];
}

class SavingFoodProduct extends ScanProductState {
  const SavingFoodProduct();
}

class RemovingFoodProduct extends ScanProductState {
  const RemovingFoodProduct();
}

class FoodProductSaved extends ScanProductState {
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

class FetchingProductsList extends ScanProductState {
  const FetchingProductsList();
}

class SavedProductsListFetched extends ScanProductState {
  const SavedProductsListFetched({required this.savedProductsList});

  final List<FoodProduct> savedProductsList;
}

class ProductNotFound extends ScanProductState {
  const ProductNotFound();
}

class ScanProductError extends ScanProductState {
  const ScanProductError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
