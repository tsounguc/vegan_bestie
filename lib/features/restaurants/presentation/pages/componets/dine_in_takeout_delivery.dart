import 'package:flutter/material.dart';

class DineInTakeoutDeliveryWidget extends StatelessWidget {
  DineInTakeoutDeliveryWidget({
    required this.dineIn, required this.takeout, required this.delivery, super.key,
  });
  bool? dineIn;
  bool? takeout;
  bool? delivery;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: dineIn == true,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: VerticalDivider(
                    color: Colors.grey.shade800,
                    thickness: 2,
                    // width: 20,
                  ),
                ),
                Icon(
                  Icons.restaurant,
                  color: Colors.grey.shade800,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Dine-in',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: takeout == true,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: VerticalDivider(
                    color: Colors.grey.shade800,
                    thickness: 2,
                    width: 20,
                  ),
                ),
                Icon(
                  Icons.takeout_dining,
                  color: Colors.grey.shade800,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Takeout',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: delivery == true,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: VerticalDivider(
                    color: Colors.grey.shade800,
                    thickness: 2,
                    width: 20,
                  ),
                ),
                Icon(
                  Icons.delivery_dining,
                  color: Colors.grey.shade800,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Delivery',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
