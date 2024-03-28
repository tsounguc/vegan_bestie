import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/features/search/presentation/search_bloc/search_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: TextField(
              // focusNode: new FocusNode(),
              controller: BlocProvider.of<SearchBloc>(context).searchTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.background),
                suffixIcon: state is SearchQueryChangedState && state.textControllerText.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.background),
                        onPressed: () {
                          BlocProvider.of<SearchBloc>(context).searchTextController.clear();
                          BlocProvider.of<SearchBloc>(context).add(SearchQueryClearedEvent());
                        },
                      )
                    : null,
                hintText: 'Search Product',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 16.sp),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.black),
              // focusNode: new FocusNode(),
              onTap: () {
                if (BlocProvider.of<SearchBloc>(context).searchTextController.text.isNotEmpty) {
                  BlocProvider.of<SearchBloc>(context).add(SearchQueryChangedEvent(
                      searchQuery: BlocProvider.of<SearchBloc>(context).searchTextController.text,),);
                } else if (BlocProvider.of<SearchBloc>(context).searchTextController.text.isEmpty) {
                  BlocProvider.of<SearchBloc>(context).add(SearchQueryClearedEvent());
                }
              },
              onChanged: (searchQuery) {
                if (searchQuery.isNotEmpty) {
                  BlocProvider.of<SearchBloc>(context).add(SearchQueryChangedEvent(searchQuery: searchQuery));
                } else if (searchQuery.isEmpty) {
                  BlocProvider.of<SearchBloc>(context).add(SearchQueryClearedEvent());
                }
              },
              onSubmitted: (searchQuery) {
                BlocProvider.of<SearchBloc>(context).searchTextController.text = searchQuery;
                BlocProvider.of<SearchBloc>(context).searchTextController.selection = TextSelection.fromPosition(
                  TextPosition(
                    offset: BlocProvider.of<SearchBloc>(context).searchTextController.text.length,
                  ),
                );
                if (searchQuery.isNotEmpty) {
                  BlocProvider.of<SearchBloc>(context).add(SearchQuerySubmittedEvent(query: searchQuery));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
