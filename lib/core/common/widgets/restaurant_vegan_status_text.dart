import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantVeganStatusText extends StatelessWidget {
  const RestaurantVeganStatusText({
    required this.isVegan,
    super.key,
  });

  final bool isVegan;

  @override
  Widget build(BuildContext context) {
    return Text(
      isVegan == true ? 'Vegan' : 'Vegan Options',
      style: TextStyle(
        color: isVegan == true ? Colors.green : Colors.purple,
        fontSize: 10.sp,
      ),
    );
  }
}
