import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_restaurants_pages.dart';
import 'package:sheveegan/features/profile/presentation/widgets/product_card.dart';

class SavedFoodsSection extends StatelessWidget {
  const SavedFoodsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedProductsProvider>(builder: (_, productsProvider, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(
              top: 5.h,
              bottom: 5.h,
            ),
            child: SectionHeader(
              sectionTitle: 'Saved Food Products',
              seeAll:
                  productsProvider.savedProductsList != null && productsProvider.savedProductsList!.length >= 4,
              onSeeAll: () => Navigator.of(context).pushNamed(
                AllSavedRestaurantsPage.id,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: productsProvider.savedProductsList == null
                    ? [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 45,
                            horizontal: 35,
                          ),
                          child: CircularProgressIndicator(),
                        ),
                      ]
                    : productsProvider.savedProductsList!.isEmpty
                        ? [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 50,
                                horizontal: 35,
                              ),
                              child: Text(
                                'Food Products will be here '
                                'once saved',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: context.theme.textTheme.bodySmall?.color,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ]
                        : productsProvider.savedProductsList!
                            .take(4)
                            .map(
                              (product) => Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ProductCard(
                                  product: product,
                                  onTap: () => Navigator.of(
                                    context,
                                  ).pushNamed(
                                    ProductFoundPage.id,
                                    arguments: product,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
              ),
            ),
          ),
        ],
      );
    });
  }
}
