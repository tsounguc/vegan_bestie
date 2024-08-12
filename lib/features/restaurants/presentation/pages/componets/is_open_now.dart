import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

//ignore: must_be_immutable
class IsOpenNowWidget extends StatelessWidget {
  IsOpenNowWidget({
    required this.openHours,
    this.visible = true,
    this.isFromDetailedPage = false,
    this.iconSize = 16,
    this.fontSize = 12,
    super.key,
  });

  final double? iconSize;
  final bool visible;
  final bool isFromDetailedPage;
  final double? fontSize;
  final OpenHours openHours;

  @override
  Widget build(BuildContext context) {
    final isStoreOpen = CoreUtils.checkOpenStatus(context, openHours.periods);
    // checkOpenStatus(context, openHours);
    return Visibility(
      visible: visible == true,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(
            vertical: openHours.periods.isEmpty ? 0 : 12.r,
            horizontal: 12.r,
          ),
          elevation: openHours.periods.isEmpty ? 0 : 2,
        ).copyWith(
          backgroundColor: MaterialStatePropertyAll(
            isFromDetailedPage && openHours.periods.isEmpty
                ? context.theme.colorScheme.background
                : context.theme.cardTheme.color,
          ),
          surfaceTintColor: MaterialStatePropertyAll(
            isFromDetailedPage && openHours.periods.isEmpty
                ? context.theme.colorScheme.background
                : context.theme.cardTheme.color,
          ),
        ),
        onPressed: !(isFromDetailedPage && openHours.periods.isNotEmpty)
            ? null
            : () => CoreUtils.displayHoursDialog(
                  context,
                  openHours.periods,
                ),
        icon: Icon(
          Icons.access_time,
          size: iconSize,
          color: isStoreOpen == 'Open Now' ? Colors.green : Colors.red,
        ),
        label: Text(
          isStoreOpen,
          style: TextStyle(
            color: isStoreOpen == 'Open Now' ? Colors.green : Colors.red,
            fontSize: fontSize?.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
