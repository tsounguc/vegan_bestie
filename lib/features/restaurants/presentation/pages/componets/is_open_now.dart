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
  List<String> weekdaysText = [];
  final OpenHours openHours;

  String getOpeningHours(BuildContext context) {
    var status = 'Closed';
    final date = DateTime.now();
    var from = '';
    var to = '';
    final todaysWeekDay = DateFormat('EEEE').format(date).toLowerCase().capitalizeFirstLetter();

    final daysOfTheWeek = context.daysOfTheWeek;
    var dayName = '';
    var daysOpenHours = '';
    if (openHours.periods.isNotEmpty) {
      for (final period in openHours.periods) {
        dayName = daysOfTheWeek[period.open.day]!;

        // Set day and open hours
        // Example: Monday 06:00 - 11:00
        if (period.open.time.isNotEmpty && period.close.time.isNotEmpty) {
          final df = DateFormat.jm();

          var openTime = period.open.time;

          final openHour = int.tryParse(openTime.split(':')[0]) ?? -1;
          final openMinutes = int.tryParse(openTime.split(':')[1]) ?? -1;
          final fromDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            openHour,
            openMinutes,
          );

          var closeTime = period.close.time;

          final closeHour = int.tryParse(closeTime.split(':')[0]) ?? -1;
          final closeMinutes = int.tryParse(closeTime.split(':')[1]) ?? -1;
          final toDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            closeHour,
            closeMinutes,
          );

          openTime = df.format(fromDateTime);
          closeTime = df.format(toDateTime);

          daysOpenHours = '$dayName $openTime - $closeTime';
        } else {
          daysOpenHours = '$dayName Closed';
        }

        weekdaysText.add(daysOpenHours);

        if (daysOfTheWeek[period.open.day] == todaysWeekDay) {
          from = period.open.time;
          final fromSplit = from.split(':');
          final fromHour = int.tryParse(fromSplit[0]) ?? -1;
          final fromMinutes = int.tryParse(fromSplit[1]) ?? -1;
          var fromTime = DateTime(
            date.year,
            date.month,
            date.day,
            fromHour,
            fromMinutes,
          );
          to = period.close.time;
          final toHour = int.tryParse(to.split(':')[0]) ?? -1;
          final toMinutes = int.tryParse(to.split(':')[1]) ?? -1;
          var toTime = DateTime(
            date.year,
            date.month,
            date.day,
            toHour,
            toMinutes,
          );

          if (fromHour == -1 || fromMinutes == -1 || toHour == -1 || toMinutes == -1) {
            status = '';
          } else {
            if (toTime.isBefore(fromTime)) {
              if (date.isBefore(fromTime) && date.hour > 12) {
                toTime = toTime.add(const Duration(days: 1));
              } else if (date.isAfter(fromTime) && date.hour < 12) {
                fromTime = fromTime.subtract(const Duration(days: 1));
              }
            }

            if (date.isAfter(fromTime) && date.isBefore(toTime)) {
              status = 'Open Now';
            }
          }
        }
      }
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final isStoreOpen = getOpeningHours(context);
    return Visibility(
      visible: visible == true,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: weekdaysText.isEmpty ? 0 : 12.r, horizontal: 12.r),
          elevation: weekdaysText.isEmpty ? 0 : 2,
        ).copyWith(
          backgroundColor: MaterialStatePropertyAll(
            isFromDetailedPage && weekdaysText.isEmpty
                ? context.theme.colorScheme.background
                : context.theme.cardTheme.color,
          ),
          surfaceTintColor: MaterialStatePropertyAll(
            isFromDetailedPage && weekdaysText.isEmpty
                ? context.theme.colorScheme.background
                : context.theme.cardTheme.color,
          ),
        ),
        onPressed: !(isFromDetailedPage && weekdaysText.isNotEmpty)
            ? null
            : () => CoreUtils.displayHoursDialog(
                  context,
                  weekdaysText,
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
