import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/presentation/pages/food_product_report_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/update_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/widgets/macronutrient_widget.dart';

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

  void gotoUpdateFoodProductPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      UpdateFoodProductScreen.id,
      arguments: UpdateFoodProductPageArguments('Edit Product', product),
    );
  }

  void goToReportIssue(BuildContext context, FoodProduct product) {
    Navigator.pushNamed(
      context,
      FoodProductReportScreen.id,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 12).copyWith(bottom: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.macrosText,
                style: TextStyle(
                  // color: Colors.grey.shade800,
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
                value: product.nutriments.proteinsServing,
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
                value: product.nutriments.carbohydratesServing,
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
                value: product.nutriments.fatServing,
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
                  // color: Colors.grey.shade800,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height * 0.0075),
        Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          interactive: true,
          radius: const Radius.circular(10),
          thickness: 10,
          child: SizedBox(
            height: product.ingredientsText.isEmpty ? context.height * 0.08 : context.height * 0.15,
            width: context.width * 0.9,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 55,
                  vertical: product.ingredientsText.isNotEmpty ? context.height * 0.0025 : 20,
                ).copyWith(bottom: 0),
                child: product.ingredientsText.isNotEmpty
                    ? Text(
                        product.ingredientsText.toLowerCase().capitalizeEveryWord(', ').capitalizeEveryWord(' ('),
                        style: TextStyle(
                          // color: Colors.grey.shade800,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Center(
                        child: Text(
                          Strings.ingredientsNotFoundText,
                          style: TextStyle(
                            // color: Colors.grey.shade800,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              surfaceTintColor: context.theme.cardTheme.color,
              backgroundColor: context.theme.cardTheme.color,
            ),
            onPressed: () => user != null && user.isAdmin
                ? gotoUpdateFoodProductPage(context)
                : goToReportIssue(context, product),
            icon: const Icon(
              Icons.report_outlined,
              color: Colors.red,
            ),
            label: Text(
              context.currentUser!.isAdmin ? 'Fix Issue' : 'Report Issue',
              style: TextStyle(
                color: context.theme.textTheme.titleSmall?.color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
