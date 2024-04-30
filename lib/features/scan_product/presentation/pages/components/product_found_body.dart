import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/macronutrient_widget.dart';

class ProductFoundBody extends StatelessWidget {
  const ProductFoundBody({
    required this.fatPercentage,
    required this.carbsPercentage,
    required this.proteinsPercentage,
    required this.product,
    required this.scrollController,
    super.key,
  });

  final double fatPercentage;
  final double carbsPercentage;
  final double proteinsPercentage;
  final FoodProduct product;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.macrosText,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.height * 0.0025,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 55,
            vertical: context.height * 0.0025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MacroNutrientWidget(
                title: Strings.proteinText,
                percentage: proteinsPercentage,
                icon: Image.asset(
                  'assets/tofu.png',
                  fit: BoxFit.contain,
                  height: 10,
                  width: 10,
                ),
                color: Colors.green.shade800,
                value: product.nutriments.proteinsValue,
              ),
              SizedBox(height: context.height * 0.0075),
              MacroNutrientWidget(
                title: Strings.carbsText,
                percentage: carbsPercentage,
                icon: Image.asset(
                  'assets/bread.png',
                  fit: BoxFit.contain,
                  height: 10,
                  width: 10,
                ),
                color: Colors.amberAccent.shade100,
                value: product.nutriments.carbohydratesValue,
              ),
              SizedBox(
                height: context.height * 0.0075,
              ),
              MacroNutrientWidget(
                title: Strings.fatText,
                percentage: fatPercentage,
                icon: Image.asset(
                  'assets/avocado.png',
                  fit: BoxFit.contain,
                  height: 10,
                  width: 10,
                ),
                color: Colors.deepPurpleAccent.shade100,
                value: product.nutriments.fatValue,
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.ingredientsText,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height * 0.005),
        Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          radius: const Radius.circular(10),
          thickness: 10,
          child: SizedBox(
            height: context.height * 0.15,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 55,
                  vertical: context.height * 0.0025,
                ),
                child: product.ingredientsText.isNotEmpty
                    ? Text(
                        product.ingredientsText,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                Strings.ingredientsNotFoundText,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  surfaceTintColor: Colors.white,
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.warning_amber,
                                  color: Colors.amber,
                                ),
                                label: Text(
                                  'Report',
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
