import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/product_info_model.dart';

class ProductFoundTabBarView extends StatefulWidget {
  final Product product;
  const ProductFoundTabBarView({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductFoundTabBarView> createState() => _ProductFoundTabBarViewState();
}

class _ProductFoundTabBarViewState extends State<ProductFoundTabBarView> with SingleTickerProviderStateMixin {
  List<Widget>? _children;
  TabController? _tabController;
  String ingredients = "";

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    widget.product.ingredients!.forEach((ingredient) {
      if (ingredient.text != widget.product.ingredients![widget.product.ingredients!.length - 1].text) {
        ingredients = ingredients + ingredient.text! + " • ";
      } else {
        ingredients = ingredients + ingredient.text!;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          TabBar(
            indicatorColor: Theme.of(context).backgroundColor,
            indicatorWeight: 3,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            controller: _tabController,
            tabs: [
              Tab(
                text: "Product",
              ),
              Tab(
                text: "More Info",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Barcode: ${widget.product.code}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0.h),
                        child: Text(
                          "Ingredients: ",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 8.0.w,
                              right: 48.0.w,
                            ),
                            child: Text(
                              widget.product.ingredientsText != null && widget.product.ingredientsText!.isNotEmpty
                                  ? ingredients
                                  : 'INGREDIENTS NOT FOUND',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Flexible(
                      //       child: Text(
                      //         'Allergens: ${widget.product.allergens?.replaceAll("en:", "") ?? ""}',
                      //         style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
