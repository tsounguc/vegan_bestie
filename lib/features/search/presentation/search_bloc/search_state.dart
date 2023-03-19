part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  bool get hasReachedEndOfResults;
  const SearchState();
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
  final List<SearchProductEntity> searchProducts;

  SearchFoundState({required this.searchProducts});
  @override
  List<Object?> get props => [];

  @override
  bool get hasReachedEndOfResults => true;
}

class SearchQueryChangedState extends SearchState {
  final String textControllerText;

  SearchQueryChangedState({required this.textControllerText});

  @override
  bool get hasReachedEndOfResults => true;

  @override
  List<Object?> get props => [];
}

class SearchProductDetailState extends SearchState {
  final SearchProductEntity? selectedProduct;
  final bool? isVegan;
  final String? nonVeganIngredientsInProduct;
  SearchProductDetailState({this.selectedProduct, this.isVegan, this.nonVeganIngredientsInProduct});

  @override
  bool get hasReachedEndOfResults => true;

  @override
  List<Object?> get props => [];
}

class SearchQueryNotFoundState extends SearchState {
  final String message;

  SearchQueryNotFoundState({required this.message});

  @override
  bool get hasReachedEndOfResults => true;

  @override
  List<Object?> get props => [];
}

class SearchErrorState extends SearchState {
  final error;

  SearchErrorState({required this.error});

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
