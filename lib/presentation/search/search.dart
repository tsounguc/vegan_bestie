import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/logic/bloc/search_bloc.dart';
import 'package:sheveegan/presentation/search/search_product_detail.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          toolbarHeight: 65.h,
          automaticallyImplyLeading: false,
          title: BlocBuilder<SearchBloc, SearchState>(
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
                      prefixIcon: Icon(Icons.search, color: Theme.of(context).backgroundColor),
                      suffixIcon: state is SearchQueryChangedState && state.textControllerText.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.cancel, color: Theme.of(context).backgroundColor),
                              onPressed: () {
                                BlocProvider.of<SearchBloc>(context).searchTextController.clear();
                                BlocProvider.of<SearchBloc>(context).add(SearchQueryClearedEvent());
                              },
                            )
                          : null,
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 16.sp),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.black),
                    // focusNode: new FocusNode(),
                    onTap: () {
                      if (BlocProvider.of<SearchBloc>(context).searchTextController.text.isNotEmpty) {
                        BlocProvider.of<SearchBloc>(context).add(SearchQueryChangedEvent(
                            searchQuery: BlocProvider.of<SearchBloc>(context).searchTextController.text));
                      } else if (BlocProvider.of<SearchBloc>(context).searchTextController.text.isEmpty) {
                        BlocProvider.of<SearchBloc>(context).add(SearchQueryClearedEvent());
                      }
                    },
                    onChanged: (searchQuery) {
                      if (searchQuery.isNotEmpty) {
                        BlocProvider.of<SearchBloc>(context)
                            .add(SearchQueryChangedEvent(searchQuery: searchQuery));
                      } else if (searchQuery.isEmpty) {
                        BlocProvider.of<SearchBloc>(context).add(SearchQueryClearedEvent());
                      }
                    },
                    onSubmitted: (searchQuery) {
                      BlocProvider.of<SearchBloc>(context).searchTextController.text = searchQuery;
                      BlocProvider.of<SearchBloc>(context).searchTextController.selection =
                          TextSelection.fromPosition(
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
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Colors.green.shade50,
        // backgroundColor: Theme.of(context).backgroundColor,
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, state) {
            if (state is SearchingState) {
              return Center(child: CircularProgressIndicator());
            } else if(state is SearchQueryNotFoundState) {
              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Spacer(),
                  Text(
                    "Product Not Found",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  ImageIcon(
                    AssetImage('assets/logo/VeganBestie_NoBackground_Fixed2.png'),
                    size: 170.r,
                    color: Colors.grey,
                  ),
                  Spacer(),
                  Flexible(
                    child: Text(
                      "We were not able to find ${state.message}",
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
            }
            else if (state is SearchErrorState) {
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Flexible(child: Text('${state.error}' , style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),),),
                    Spacer(),
                  ],
                ),
              );
            } else if (state is SearchFoundState) {
              return NotificationListener<ScrollNotification>(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.searchResults?.products!.length,
                  itemBuilder: (context, index) {
                    if (state.searchResults?.products![index].productName != null &&
                        state.searchResults!.products![index].productName!.isNotEmpty &&
                        state.searchResults?.products![index].imageThumbUrl != null &&
                        state.searchResults!.products![index].imageThumbUrl!.isNotEmpty) {
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.r, top: 16.r, left: 8.0, bottom: 16.0.r),
                          child: ListTile(
                            leading: state.searchResults?.products![index].imageThumbUrl != null &&
                                    state.searchResults!.products![index].imageThumbUrl!.isNotEmpty
                                ? CachedNetworkImage(
                                    height: 50.r,
                                    width: 50.r,
                                    fit: BoxFit.fill,
                                    imageUrl: state.searchResults!.products![index].imageThumbUrl!,
                                  )
                                : Icon(
                                    Icons.image_outlined,
                                    size: 50.r,
                                    color: Colors.black,
                                  ),
                            title: Text(
                              state.searchResults!.products![index].productName!,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                BlocProvider.of<SearchBloc>(context).add(SearchProductPressedEvent(
                                    selectedProduct: state.searchResults!.products![index]));
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => SearchProductDetail()));
                              },
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              );
            } else if(state is InitialSearchState){
              return Center(
                child: Opacity(
                  opacity: 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search, color: Colors.black, size: 40.r),
                      Text(
                        "Start Searching!",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
              return Container();

          },
        ),
      ),
    );
  }

  int calculateListItemCount(SearchState state) {
    if (state is SearchFoundState && state.hasReachedEndOfResults) {
      return state.searchResults!.pageSize;
    } else if (state is SearchFoundState && !state.hasReachedEndOfResults) {
      return state.searchResults!.pageSize + 1;
    } else {
      return 0;
    }
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {}
    return false;
  }
}
