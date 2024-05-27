import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';

class IsOpenNowWidget extends StatelessWidget {
  const IsOpenNowWidget({
    required this.isOpenNow,
    required this.weekdayText,
    this.visible = true,
    this.iconSize = 16,
    this.fontSize = 12,
    super.key,
  });

  final double? iconSize;
  final bool visible;
  final bool isOpenNow;
  final double? fontSize;
  final List<String> weekdayText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible == true,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          // backgroundColor: context.theme.cardTheme.color,
          // surfaceTintColor: context.theme.cardTheme.color,
          shape: weekdayText.isEmpty
              ? null
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
          padding: weekdayText.isEmpty ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 12.r, horizontal: 12.r),
          elevation: weekdayText.isEmpty ? 0 : 2,
        ).copyWith(
          backgroundColor: MaterialStatePropertyAll(context.theme.cardTheme.color),
          surfaceTintColor: MaterialStatePropertyAll(context.theme.cardTheme.color),
        ),
        onPressed: weekdayText.isEmpty
            ? null
            : () => CoreUtils.displayHoursDialog(
                  context,
                  weekdayText,
                ),
        icon: Icon(
          Icons.access_time,
          size: iconSize,
          color: isOpenNow ? Colors.green : Colors.red,
        ),
        label: Text(
          isOpenNow ? 'Open Now' : 'Closed',
          style: TextStyle(
            color: isOpenNow ? Colors.green : Colors.red,
            fontSize: fontSize?.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
