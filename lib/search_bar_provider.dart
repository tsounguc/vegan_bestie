import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/interface/Parameter.dart';
import 'package:openfoodfacts/model/SearchResult.dart';
import 'package:openfoodfacts/model/User.dart';
import 'package:openfoodfacts/model/parameter/SortBy.dart';
import 'package:openfoodfacts/model/parameter/TagFilter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/LanguageHelper.dart';
import 'package:openfoodfacts/utils/ProductFields.dart';
import 'package:openfoodfacts/utils/ProductSearchQueryConfiguration.dart';
import 'package:sheveegan/search_model.dart';

class SearchBarStateNotifier extends StateNotifier<SearchModel> {
  SearchBarStateNotifier() : super(SearchModel());

  static const historyLength = 5;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // The raw history that we don't access from the UI, prefilled with values
  List<String?> _searchHistory = [
    // 'almond milk',
    // 'chocolate',
    // 'cereal',
    // 'bread',
  ];

  // The filtered & ordered history that's accessed from the UI
  List<String?> _filteredSearchHistory = [];

  List<String?> get getFilteredSearchHistory => _filteredSearchHistory;

  set setFilteredSearchHistory(List<String> value) {
    _filteredSearchHistory = value;
    state = state..suggestions = _filteredSearchHistory;
  }

  String _query = "";

  //The currently searched-for term
  String? selectedTerm;

  Future onQueryChanged(String query) async {
    try {
      if (query == _query) return;
      _query = query;
      _searchHistory = [];
      _isLoading = true;
      state = state
        ..query = _query
        ..suggestions = _searchHistory
        ..isLoading = _isLoading;
      if (query.isEmpty) {
        _filteredSearchHistory = _searchHistory;
        _isLoading = false;
        state = state..isLoading = _isLoading;
      } else {
        // _searchHistory = results.products!.map((e) => e.productName).toList();
        // for (int i = 0; i < _searchHistory.length; i++) {
        //   if (_searchHistory[i] == "" || _searchHistory[i] == null) {
        //     print("null or blank ${_searchHistory[i]}");
        //     _searchHistory.remove(_searchHistory[i]);
        //   }
        // }

        var parameters = <Parameter>[
          SortBy(option: SortOption.PRODUCT_NAME),
          TagFilter(
            contains: true,
            tagName: query,
            tagType: 'categories',
          )
        ];

        ProductSearchQueryConfiguration configuration =
            ProductSearchQueryConfiguration(
          parametersList: parameters,
          language: OpenFoodFactsLanguage.ENGLISH,
          fields: [ProductField.ALL],
        );
        User myUser =
            User(userId: 'christian-tsoungui-nkoulou', password: 'Whatsupbro3');

        SearchResult results =
            await OpenFoodAPIClient.searchProducts(myUser, configuration);
        List<String?> list = [];
        for (int i = 0; i < results.products!.length; i++) {
          if (results.products![i].productName != null &&
              results.products![i].productName!.isNotEmpty) {
            print('${results.products?[i].productName}');
            list.add(results.products![i].productName!);
          }
        }
        print("Search History: $list");
        _filteredSearchHistory = list;
        // _filteredSearchHistory = _searchHistory;
        // _filteredSearchHistory = filterSearchTerms(filter: query);
        _isLoading = false;
        print("filtered search history: $_filteredSearchHistory");
        state = state
          ..query = query
          ..suggestions = _filteredSearchHistory
          ..isLoading = _isLoading;
      }
    } on PlatformException catch (e) {
      print("PlatformException: $e");
    } on Exception catch (e) {
      print("Exception: $e");
    }
  }

  Future searchProduct(String query) async {
    try {
      var parameters = <Parameter>[
        SortBy(option: SortOption.PRODUCT_NAME),
        TagFilter(
          contains: true,
          tagName: query,
          tagType: 'categories',
        )
      ];

      ProductSearchQueryConfiguration configuration =
          ProductSearchQueryConfiguration(
        parametersList: parameters,
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [ProductField.ALL],
      );
      User myUser =
          User(userId: 'christian-tsoungui-nkoulou', password: 'Whatsupbro3');

      SearchResult results =
          await OpenFoodAPIClient.searchProducts(myUser, configuration);
      List<String?> list = [];
      for (int i = 0; i < results.products!.length; i++) {
        if (results.products![i].productName!.isEmpty) {
          print('${results.products![i].productName}');
          list.add(results.products![i].productName!);
        }
      }
      return list;
    } on Exception catch (e) {
      print(e);
    }
  }

  void clear() {
    _filteredSearchHistory = _searchHistory;
    state = state..suggestions = _filteredSearchHistory;
  }

  List<String?> filterSearchTerms({
    String? filter,
  }) {
    List<String?> filteredList = [];
    if (filter!.isNotEmpty) {
      filteredList = _searchHistory.reversed
          .where((term) => term!.startsWith(filter))
          .toList();
    } else {
      filteredList = _searchHistory.reversed.toList();
    }
    return filteredList;
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    _filteredSearchHistory = filterSearchTerms(filter: "");
    state = state..suggestions = _filteredSearchHistory;
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }
}

final searchBarProductProvider = StateNotifierProvider<SearchBarStateNotifier>(
    (ref) => new SearchBarStateNotifier());
