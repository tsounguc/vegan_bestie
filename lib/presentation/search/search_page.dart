import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/logic/bloc/search_bloc.dart';
import 'package:sheveegan/presentation/search/widgets/search_bar.dart';
import 'package:sheveegan/presentation/search/searchProductDetail/search_product_detail.dart';
import 'package:sheveegan/presentation/search/widgets/search_initial_state_widget.dart';

import '../widgets/error.dart';
import '../widgets/loading.dart';
import '../widgets/product_not_found.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
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
          title: SearchBar(),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Colors.green.shade50,
        // backgroundColor: Theme.of(context).backgroundColor,
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, state) {
            if (state is SearchingState) {
              return LoadingPage();
            } else if (state is SearchQueryNotFoundState) {
              return ProductNotFoundPage(message: state.message);
            } else if (state is SearchErrorState) {
              return ErrorPage(
                error: state.error,
              );
            } else if (state is SearchInitialState) {
              return SearchInitialStateWidget();
            } else if (state is SearchFoundState) {
              return NotificationListener<ScrollNotification>(
                child: ListView.builder(
                  itemCount: state.searchResults?.products!.length,
                  itemBuilder: (context, index) {
                    if (state.searchResults?.products![index].productName != null &&
                        state.searchResults!.products![index].productName!.isNotEmpty) {
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
            }
            return Container();
          },
        ),
      ),
    );
  }
}
