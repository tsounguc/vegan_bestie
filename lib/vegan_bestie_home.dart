import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/product_provider.dart';
import 'package:sheveegan/router.dart';
import 'package:sheveegan/search_bar_provider.dart';
import 'package:sheveegan/size_config.dart';

import 'assets/vegan_icon.dart';

class VeganBestieHome extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var searchResult = useProvider(searchBarProductProvider);
    FloatingSearchBarController controller = FloatingSearchBarController();
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade800),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FloatingSearchBar(
          controller: controller,
          hint: "Search product",
          scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: BouncingScrollPhysics(),
          axisAlignment: 0.0,
          openAxisAlignment: 0.0,
          progress: context.read(searchBarProductProvider.state).isLoading,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: context.read(searchBarProductProvider).onQueryChanged,
          onSubmitted: (query) {
            context.read(searchBarProductProvider).addSearchTerm(query);
            context.read(searchBarProductProvider).selectedTerm = query;
            // controller.close();
          },
          transition: CircularFloatingSearchBarTransition(),
          actions: [
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
                elevation: 4,
                child: Builder(builder: (context) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: context
                          .read(searchBarProductProvider.state)
                          .suggestions
                          .length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            context
                                .read(searchBarProductProvider.state)
                                .suggestions[index]!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {},
                        );
                      });
                }),
              ),
            );
            // return ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: Material(
            //       color: Colors.white,
            //       elevation: 4,
            //       child: Builder(
            //         builder: (context) {
            //           //history is empty and the user hasn't typed in any search
            //           if (context
            //                   .read(searchBarProductProvider)
            //                   .getFilteredSearchHistory
            //                   .isEmpty &&
            //               controller.query.isEmpty) {
            //             return Container(
            //               height: 56,
            //               width: double.infinity,
            //               alignment: Alignment.center,
            //               child: Text(
            //                 "Start search",
            //                 maxLines: 1,
            //                 overflow: TextOverflow.ellipsis,
            //                 style: Theme.of(context).textTheme.caption,
            //               ),
            //             );
            //           } else if (context //history is empty but user has typed in a search
            //               .read(searchBarProductProvider)
            //               .getFilteredSearchHistory
            //               .isEmpty) {
            //             return ListTile(
            //                 title: Text(controller.query),
            //                 leading: const Icon(Icons.search),
            //                 onTap: () {
            //                   context
            //                       .read(searchBarProductProvider)
            //                       .addSearchTerm(controller.query);
            //                   context
            //                       .read(searchBarProductProvider)
            //                       .selectedTerm = controller.query;
            //                   controller.close();
            //                 });
            //             // return Container();
            //           } else {
            //             return Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: context
            //                     .read(searchBarProductProvider)
            //                     .getFilteredSearchHistory
            //                     .map(
            //                       (term) => ListTile(
            //                         title: Text(
            //                           term,
            //                           maxLines: 1,
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                         leading: const Icon(Icons.history),
            //                         trailing: IconButton(
            //                           icon: const Icon(Icons.clear),
            //                           onPressed: () {
            //                             context
            //                                 .read(searchBarProductProvider)
            //                                 .deleteSearchTerm(term);
            //                           },
            //                         ),
            //                         onTap: () {},
            //                       ),
            //                     )
            //                     .toList());
            //           }
            //         },
            //       )),
            // );
          },
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical! * 18),
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
                                  builder: (context) => VeganBestieRouter());
                              Navigator.push(context, route);
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(20),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black),
                              alignment: FractionalOffset(
                                (SizeConfig.blockSizeHorizontal! * 27) *
                                    -0.0011,
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
        ),
      ),
    );
  }
}
