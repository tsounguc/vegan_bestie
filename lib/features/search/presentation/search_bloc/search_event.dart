part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchButtonPressedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchQuerySubmittedEvent extends SearchEvent {
  final String query;
  SearchQuerySubmittedEvent({required this.query});

  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchEvent {
  final String searchQuery;
  SearchQueryChangedEvent({required this.searchQuery});
  @override
  List<Object?> get props => [];
}

class SearchQueryClearedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductPressedEvent extends SearchEvent {
  final ProductInfoModel selectedProduct;
  SearchProductPressedEvent({required this.selectedProduct});

  @override
  List<Object?> get props => [];
}

class SearchDetailBackButtonPressedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
