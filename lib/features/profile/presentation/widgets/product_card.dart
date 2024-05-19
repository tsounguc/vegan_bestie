import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    this.onTap,
    super.key,
  });

  final FoodProduct product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8)
                  .copyWith(top: 3),
              child: product.imageFrontUrl.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: product.isVegan
                            ? Colors.green.shade50
                            : product.isVegetarian
                                ? const Color(0xFFe2e360)
                                : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        size: MediaQuery.of(context).size.width * 0.35,
                        color: Colors.white,
                      ),
                    )
                  : Ink(
                      height: MediaQuery.of(context).size.width * 0.35,
                      width: MediaQuery.of(context).size.width * 0.35,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(
                  product.productName.capitalizeFirstLetter(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
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
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
