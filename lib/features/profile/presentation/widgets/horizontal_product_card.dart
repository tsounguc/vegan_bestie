import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    required this.product,
    super.key,
  });

  final FoodProduct product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        ProductFoundPage.id,
        arguments: product,
      ),
      child: Card(
        // color: Colors.white,
        clipBehavior: Clip.antiAlias,
        // surfaceTintColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
                top: MediaQuery.of(context).size.width * 0.030,
                bottom: MediaQuery.of(context).size.width * 0.030,
              ),
              child: Center(
                child: product.imageFrontUrl.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: product.isVegan
                              ? Colors.green.shade50
                              : product.isVegetarian
                                  ? Colors.purple.shade50
                                  : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.image_outlined,
                          size: MediaQuery.of(context).size.width * 0.30,
                          color: Colors.white,
                        ),
                      )
                    : Ink(
                        height: MediaQuery.of(context).size.width * 0.30,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              product.imageFrontUrl,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              product.productName.capitalizeFirstLetter(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                // color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.007,
                    ),
                    Row(
                      children: [
                        Text(
                          product.isVegan
                              ? 'Vegan'
                              : product.isVegetarian
                                  ? 'Vegetarian'
                                  : '',
                          style: TextStyle(
                            color: product.isVegan
                                ? context.theme.primaryColor
                                : product.isVegetarian
                                    ? Colors.purple.shade200
                                    : Colors.blue.shade300,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
