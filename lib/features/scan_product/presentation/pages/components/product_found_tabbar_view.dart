import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class ProductFoundTabBarView extends StatefulWidget {
  const ProductFoundTabBarView({required this.product, super.key});
  final FoodProduct product;

  @override
  State<ProductFoundTabBarView> createState() => _ProductFoundTabBarViewState();
}

class _ProductFoundTabBarViewState extends State<ProductFoundTabBarView> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String ingredients = '';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    for (final ingredient in widget.product.ingredients) {
      final index = widget.product.ingredients.length - 1;
      if (ingredient.text != widget.product.ingredients[index].text) {
        ingredients += '${ingredient.text} • ';
      } else {
        ingredients += ingredient.text;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          TabBar(
            indicatorColor: Theme.of(context).colorScheme.background,
            indicatorWeight: 3,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Product',
              ),
              Tab(
                text: 'More Info',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                          'Ingredients: ',
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
                              widget.product.ingredientsText.isNotEmpty ? ingredients : 'INGREDIENTS NOT FOUND',
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
