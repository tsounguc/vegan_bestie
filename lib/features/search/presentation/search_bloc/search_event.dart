part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchButtonPressedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchQuerySubmittedEvent extends SearchEvent {
  const SearchQuerySubmittedEvent({required this.query});
  final String query;

  @override
  List<Object?> get props => [];
}

class SearchQueryChangedEvent extends SearchEvent {
  const SearchQueryChangedEvent({required this.searchQuery});
  final String searchQuery;
  @override
  List<Object?> get props => [];
}

class SearchQueryClearedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductPressedEvent extends SearchEvent {
  const SearchProductPressedEvent({required this.selectedProduct});
  final SearchProductEntity selectedProduct;

  @override
  List<Object?> get props => [];
}

class SearchDetailBackButtonPressedEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
