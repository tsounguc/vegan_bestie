import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            width: MediaQuery.of(context).size.width * 0.18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: VerticalDivider(
                    color: Colors.grey.shade800,
                    width: 20,
                  ),
                ),
                Icon(
                  Icons.restaurant,
                  color: Colors.grey.shade800,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Dine-in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
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
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: VerticalDivider(
                    color: Colors.grey.shade800,
                    width: 20,
                  ),
                ),
                Icon(
                  Icons.takeout_dining,
                  color: Colors.grey.shade800,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  'Takeout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
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
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: VerticalDivider(
                    color: Colors.grey.shade800,
                    width: 20,
                  ),
                ),
                Icon(
                  Icons.delivery_dining,
                  color: Colors.grey.shade800,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  'Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
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
