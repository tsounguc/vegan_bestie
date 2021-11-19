import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/product_provider.dart';
import 'package:sheveegan/she_vegan_home_page.dart';
import 'package:sheveegan/size_config.dart';

import 'assets/vegan_icon.dart';

class VeganBestieHome extends HookWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade800),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal! * 4.5,
                    top: SizeConfig.blockSizeVertical! * 4.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: SizeConfig.blockSizeVertical! * 5,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: ProductSearchDelegate(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vegan Bestie',
                      style: TextStyle(
                        color: titleTextColorOne,
                        fontSize: SizeConfig.blockSizeHorizontal! * 11,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical! * 21,
                    bottom: SizeConfig.blockSizeVertical! * 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tap to Scan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2.5,
                    ),
                    Container(
                      // color: Colors.blue,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read(productProvider)
                              .onBarcodeButtonPressed(context);
                          Route route = MaterialPageRoute(
                              builder: (context) => SheVeganHomePage());
                          Navigator.push(context, route);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(20),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          alignment: FractionalOffset(
                            (SizeConfig.blockSizeHorizontal! * 27) * -0.0011,
                            (SizeConfig.blockSizeVertical! * 27) * 0.0020,
                          ),
                          fixedSize: MaterialStateProperty.all(
                            Size.fromRadius(
                                SizeConfig.blockSizeVertical! * 13.5),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            CircleBorder(),
                          ),
                        ),
                        child: ImageIcon(
                          AssetImage(
                              'assets/logo/VeganBestie_NoBackground_Fixed2.png'),
                          size: SizeConfig.blockSizeVertical! * 22,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  late UnmodifiableListView<Product> products;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: Icon(Icons.location_city, size: 120)),
        const SizedBox(height: 48),
        Center(child: Text(query, style: TextStyle(color: Colors.black, fontSize: 64, fontWeight: FontWeight.bold),))
        //Build the results based on the searchResults stream in the searchBloc
        // StreamBuilder(
        //   stream: context.read(productProvider).searchProducts(query),
        //   builder: (context, AsyncSnapshot<List<Result>> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Center(child: CircularProgressIndicator()),
        //         ],
        //       );
        //     } else if (snapshot.data.length == 0) {
        //       return Column(
        //         children: <Widget>[
        //           Text(
        //             "No Results Found.",
        //           ),
        //         ],
        //       );
        //     } else {
        //       var results = snapshot.data;
        //       return ListView.builder(
        //         itemCount: results.length,
        //         itemBuilder: (context, index) {
        //           var result = results[index];
        //           return ListTile(
        //             title: Text(result.title),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
    // return StreamBuilder(
    //   stream: context.read(productProvider).searchProducts(query),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Container();
    //     } else {
    //       return ListView.builder(itemCount: 5, itemBuilder: (context, index) {
    //         return ListTile();
    //       });
    //     }
    //   },
    // );
  }
}
