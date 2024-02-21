part of 'product_fetch_cubit.dart';

abstract class ProductFetchState extends Equatable {
  const ProductFetchState();
}

class ProductFetchInitial extends ProductFetchState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductFetchState {
  @override
  List<Object> get props => [];
}

class ProductFoundState extends ProductFetchState {
  final ScanProductEntity product;
  final bool? isVegan;
  final String? nonVeganIngredientsInProduct;
  ProductFoundState({required this.product, this.isVegan, this.nonVeganIngredientsInProduct});

  @override
  List<Object> get props => [];
}

class ProductNotFoundState extends ProductFetchState {
  ProductNotFoundState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductFetchErrorState extends ProductFetchState {
  final error;

  ProductFetchErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
