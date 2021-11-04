class SearchModel {
  bool isLoading;
  List<String?> suggestions;
  String query;

  SearchModel(
      {this.isLoading = false, this.suggestions = const [], this.query = ""});
}

// const List<String> _searchHistory = [
//   'almond milk',
//   'chocolate',
//   'cereal',
//   'bread',
// ];
