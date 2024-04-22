import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MacroNutrientWidget extends StatelessWidget {
  const MacroNutrientWidget({
    required this.title,
    required this.icon,
    required this.percentage,
    required this.color,
    required this.value,
    super.key,
  });

  final double percentage;
  final String title;
  final Widget icon;
  final Color color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: icon,
          // child: Icon(icon, color: color),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$title (${percentage.toStringAsFixed(1)}%)',
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  ),
                  Text(
                    " ${value?.toStringAsFixed(1) ?? "0.0"} g",
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: percentage / 100,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
