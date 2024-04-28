import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class FlexibleSpaceBarBottom extends StatelessWidget {
  const FlexibleSpaceBarBottom({
    required GlobalKey<State<Tooltip>> toolTipKey,
    // required this.state,
    required this.product,
    this.onTooltipTriggered,
    super.key,
  }) : _toolTipKey = toolTipKey;

  // final ProductFound state;
  final FoodProduct product;

  final GlobalKey<State<Tooltip>> _toolTipKey;
  final void Function()? onTooltipTriggered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.r),
          topLeft: Radius.circular(25.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.width * 0.65,
            child: Text(
              product.productName.capitalize(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          if (product.ingredients.isNotEmpty)
            Container(
              height: context.width * 0.09,
              width: context.width * 0.12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Tooltip(
                key: _toolTipKey,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                textAlign: TextAlign.start,
                message: product.isVegan == true
                    ? Strings.toolTipVeganMessage
                    : product.isVegetarian == true
                        ? '${Strings.toolTipVegetarianMessage}'
                            '${product.nonVeganIngredients}'
                        : product.isVegan == false && product.isVegetarian == false
                            ? '${Strings.toolTipNonVeganMessage}'
                                '${product.nonVeganIngredients}'
                            : null,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  color: product.isVegan == true
                      ? Colors.green
                      : product.isVegetarian == true
                          ? const Color(0xFFe2e360)
                          : Colors.blue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
                triggerMode: TooltipTriggerMode.tap,
                showDuration: const Duration(
                  milliseconds: 3000,
                ),
                child: product.isVegan == true
                    ? const Icon(
                        VeganIcon.veganIcon,
                        color: Colors.green,
                        size: 25,
                      )
                    : product.isVegetarian == true
                        ? const Icon(
                            VeganIcon.veganIcon,
                            color: Color(0xFFe2e360),
                            size: 25,
                          )
                        : Center(
                            child: Icon(
                              Icons.info_outlined,
                              color: Colors.blueGrey.shade600,
                            ),
                          ),
              ),
            ),
        ],
      ),
    );
  }
}
