import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class DineInTakeoutDeliveryWidget extends StatelessWidget {
  const DineInTakeoutDeliveryWidget({
    required this.dineIn,
    required this.takeout,
    required this.delivery,
    super.key,
  });

  final bool? dineIn;
  final bool? takeout;
  final bool? delivery;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: dineIn ?? false,
          child: SizedBox(
            width: 72.w,
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    color: Colors.grey.shade700,
                    width: 15,
                  ),
                ),
                Icon(
                  Icons.restaurant,
                  color: Colors.grey.shade700,
                  size: 12,
                ),
                SizedBox(width: 3.w),
                Flexible(
                  child: Text(
                    'Dine-in',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: takeout ?? false,
          child: SizedBox(
            width: 72.w,
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    color: Colors.grey.shade700,
                    width: 15,
                  ),
                ),
                Icon(
                  Icons.takeout_dining,
                  color: Colors.grey.shade700,
                  size: 12,
                ),
                const SizedBox(width: 5),
                Text(
                  'Takeout',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: delivery ?? false,
          child: SizedBox(
            width: 74.w,
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    color: Colors.grey.shade700,
                    width: 15,
                  ),
                ),
                Icon(
                  Icons.delivery_dining,
                  color: Colors.grey.shade700,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  'Delivery',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
