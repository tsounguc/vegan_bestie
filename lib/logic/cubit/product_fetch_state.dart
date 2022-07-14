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
  final ProductInfoModel product;
  ProductFoundState({required this.product});

  @override
  List<Object> get props => [];
}

class ProductNotFoundState extends ProductFetchState {
  final String message;

  ProductNotFoundState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ProductFetchErrorState extends ProductFetchState {
  final error;

  ProductFetchErrorState({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [];

}






