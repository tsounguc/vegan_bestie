part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  bool get hasReachedEndOfResults;
}

class SearchInitialState extends SearchState {
  // TODO: Search result variable

  @override
  List<Object> get props => [];

  @override
  bool get hasReachedEndOfResults => false;
}

class SearchingState extends SearchState {
  @override
  List<Object> get props => [];

  @override
  bool get hasReachedEndOfResults => false;
}

class SearchFoundState extends SearchState {

  const SearchFoundState({required this.searchProducts});
  final List<SearchProductEntity> searchProducts;
  @override
  List<Object?> get props => [];

  @override
  bool get hasReachedEndOfResults => true;
}

class SearchQueryChangedState extends SearchState {

  const SearchQueryChangedState({required this.textControllerText});
  final String textControllerText;

  @override
  bool get hasReachedEndOfResults => true;

  @override
  List<Object?> get props => [];
}

class SearchProductDetailState extends SearchState {
  const SearchProductDetailState({this.selectedProduct, this.isVegan, this.nonVeganIngredientsInProduct});
  final SearchProductEntity? selectedProduct;
  final bool? isVegan;
  final String? nonVeganIngredientsInProduct;

  @override
  bool get hasReachedEndOfResults => true;

  @override
  List<Object?> get props => [];
}

class SearchQueryNotFoundState extends SearchState {

  const SearchQueryNotFoundState({required this.message});
  final String message;

  @override
  bool get hasReachedEndOfResults => true;

  @override
  List<Object?> get props => [];
}

class SearchErrorState extends SearchState {

  const SearchErrorState({required this.error});
  final error;

  @override
  bool get hasReachedEndOfResults => false;

  @override
  List<Object?> get props => [];
}

// class SearchDetailBackButtonPressedState extends SearchState {
//   @override
//   bool get hasReachedEndOfResults => true;
//
//   @override
//   List<Object?> get props => [];
//
// }
