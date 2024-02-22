import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/features/search/presentation/search_bloc/search_bloc.dart';

import '../../../../core/common/screens/error/error.dart';
import '../../../../core/common/screens/loading/loading.dart';
import '../../../../core/common/screens/product_screens/product_not_found.dart';
import 'components/search_bar.dart';
import 'components/search_initial_state_widget.dart';
import 'search_product_detail.dart';

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
                  itemCount: state.searchProducts.length,
                  itemBuilder: (context, index) {
                    if (state.searchProducts[index].productName != null &&
                        state.searchProducts[index].productName!.isNotEmpty) {
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0.r, top: 16.r, left: 8.0, bottom: 16.0.r),
                          child: ListTile(
                            leading: state.searchProducts[index].imageFrontUrl != null &&
                                    state.searchProducts[index].imageFrontUrl!.isNotEmpty
                                ? CachedNetworkImage(
                                    height: 50.r,
                                    width: 50.r,
                                    fit: BoxFit.fill,
                                    imageUrl: state.searchProducts[index].imageFrontUrl!,
                                  )
                                : Icon(
                                    Icons.image_outlined,
                                    size: 50.r,
                                    color: Colors.black,
                                  ),
                            title: Text(
                              state.searchProducts[index].productName!,
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
                                BlocProvider.of<SearchBloc>(context)
                                    .add(SearchProductPressedEvent(selectedProduct: state.searchProducts[index]));
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
