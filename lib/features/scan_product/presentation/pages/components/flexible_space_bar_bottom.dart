import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class FlexibleSpaceBarBottom extends StatelessWidget {
  const FlexibleSpaceBarBottom({
    required GlobalKey<State<Tooltip>> toolTipKey,
    required this.state,
    this.onTooltipTriggered,
    super.key,
  }) : _toolTipKey = toolTipKey;
  final ProductFound state;

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
            width: context.width * 0.6,
            child: Text(
              state.product.productName,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          if (state.product.ingredients.isNotEmpty)
            Container(
              height: context.width * 0.09,
              width: context.width * 0.12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
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
                message: state.isVegan == true
                    ? Strings.toolTipVeganMessage
                    : state.isVegan == false
                        ? '${Strings.toolTipNonVeganMessage} '
                            '${state.nonVeganIngredients}'
                        : null,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  color: state.isVegan == true ? Colors.green : Colors.blue,
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
                child: state.isVegan == true
                    ? const Icon(
                        VeganIcon.vegan_icon,
                        color: Colors.green,
                        size: 22,
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
