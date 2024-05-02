import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/profile/presentation/widgets/horizontal_product_card.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class AllSavedProductsPage extends StatelessWidget {
  const AllSavedProductsPage({super.key});

  static const String id = '/allSavedProductsPage';

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Consumer<SavedProductsProvider>(
      builder: (_, productsProvider, __) {
        final productsList = productsProvider.savedProductsList ?? <FoodProduct>[];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: Colors.white,
            leading: const CustomBackButton(
              color: Colors.black,
            ),
            title: Text(
              'Saved Food Products',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                // fontSize: 24,
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.height * 0.00),
                ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: productsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productsList[index];
                    return HorizontalProductCard(
                      product: product,
                    );
                  },
                ),
                SizedBox(height: context.height * 0.05),
              ],
            ),
          ),
        );
      },
    );
  }
}
