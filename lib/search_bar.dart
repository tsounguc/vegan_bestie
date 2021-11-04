import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key? key}) : super(key: key);

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  static const historyLength = 5;

  // The raw history that we don't access from the UI, prefilled with values
  List<String> _searchHistory = ['almond milk', 'chocolate', 'cereal', 'bread'];

  // The filtered & ordered history that's accessed from the UI
  List<String>? filteredSearchHistory;

  //The currently searched-for term
  String? selectedTerm;

  List<String> filterSearchTerms({
    String filter = "",
  }) {
    if (filter.isNotEmpty)
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    else
      return _searchHistory.reversed.toList();
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

    filteredSearchHistory = filterSearchTerms(filter: "");
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredSearchHistory = filterSearchTerms(filter: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
          hint: "Search product",
          scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: BouncingScrollPhysics(),
          axisAlignment: 0.0,
          openAxisAlignment: 0.0,
          width: 600,
          onQueryChanged: (query) {},
          transition: CircularFloatingSearchBarTransition(),
          // leadingActions: [],
          actions: [
            // FloatingSearchBarAction(
            //   showIfOpened: false,
            //   child: CircularButton(
            //     icon: const Icon(Icons.place),
            //     onPressed: () {},
            //   ),
            // ),
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: Colors.accents.map((color) {
                    return Container(height: 112, color: color);
                  }).toList(),
                ),
              ),
            );
          }),
    );
  }
}
