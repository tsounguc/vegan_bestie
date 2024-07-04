import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class IsOpenNowWidget extends StatelessWidget {
  IsOpenNowWidget({
    required this.isOpenNow,
    // required this.weekdayText,
    required this.openHours,
    this.visible = true,
    this.isFromDetailedPage = false,
    this.iconSize = 16,
    this.fontSize = 12,
    super.key,
  });

  final double? iconSize;
  final bool visible;
  final bool isOpenNow;
  final bool isFromDetailedPage;
  final double? fontSize;
  List<String> weekdaysText = [];
  final OpenHours openHours;

  String getOpeningHours(BuildContext context) {
    String status = 'Closed';
    DateTime date = DateTime.now();
    String from = '';
    String to = '';
    String todaysWeekDay = DateFormat('EEEE').format(date).toLowerCase().capitalizeFirstLetter();

    final daysOfTheWeek = context.daysOfTheWeek;
    var dayName = '';
    var daysOpenHours = '';
    if (openHours.periods.isNotEmpty) {
      for (final period in openHours.periods) {
        dayName = daysOfTheWeek[period.open.day]!;

        // Set day and open hours
        // Example: Monday 06:00 - 11:00
        if (period.open.time.isNotEmpty && period.close.time.isNotEmpty) {
          DateFormat df = DateFormat.jm();

          var openTime = period.open.time;

          final openHour = int.tryParse(openTime.split(':')[0]) ?? -1;
          final openMinutes = int.tryParse(openTime.split(':')[1]) ?? -1;
          var fromDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            openHour,
            openMinutes,
          );

          var closeTime = period.close.time;

          final closeHour = int.tryParse(closeTime.split(':')[0]) ?? -1;
          final closeMinutes = int.tryParse(closeTime.split(':')[1]) ?? -1;
          var toDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            closeHour,
            closeMinutes,
          );

          openTime = df.format(fromDateTime);
          closeTime = df.format(toDateTime);

          daysOpenHours = '$dayName $openTime - $closeTime';
          print(daysOpenHours);
        } else {
          daysOpenHours = '$dayName Closed';
          print(daysOpenHours);
        }

        // Add day and open hours to weekdaysText list
        // if (weekdaysText.isNotEmpty) {
        //   for (var i = 0; i < weekdaysText.length; i++) {
        //     var weekday = weekdaysText[i];
        //     // check if day already exists in weekdaysText list
        //     if (!weekday.contains(dayName)) {
        //       // Add day and open hours doesn't exist
        //       weekdaysText.add(daysOpenHours);
        //     } else if (weekday.contains(dayName)) {
        //       // Add just open hours if day exists
        //       var index = weekday.indexOf(dayName) + dayName.length;
        //       weekday = '$weekday\n\t${daysOpenHours.substring(index)}';
        //       weekdaysText[i] = weekday;
        //     }
        //   }
        // }
        // else {
        weekdaysText.add(daysOpenHours);
        // }

        if (daysOfTheWeek[period.open.day] == todaysWeekDay) {
          from = period.open.time;
          final fromSplit = from.split(':');
          print('Here: $from');
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

      // for (final index in daysOfTheWeek.keys) {
      //   for (final period in openHours.periods) {
      //     if (period.open.day == index) {
      //       dayName = daysOfTheWeek[index]!;
      //       var daysOpenHours = '';
      //
      //       // Set day and open hours
      //       // Example: Monday 06:00 - 11:00
      //       print('Open: ${period.open.time}');
      //       print('Close: ${period.close.time}');
      //       if (period.open.time.isNotEmpty && period.close.time.isNotEmpty) {
      //         final openTime = period.open.time;
      //         final closeTime = period.close.time;
      //         daysOpenHours = '$dayName $openTime - $closeTime';
      //       }
      //       // else {
      //       //   daysOpenHours = '$dayName Closed';
      //       // }
      //
      //       // Add day and open hours to weekdaysText list
      //       if (weekdaysText.isNotEmpty) {
      //         for (var i = 0; i < weekdaysText.length; i++) {
      //           var weekday = weekdaysText[i];
      //           // check if day already exists in weekdaysText list
      //           if (!weekday.contains(dayName)) {
      //             // Add day and open hours doesn't exist
      //             weekdaysText.add(daysOpenHours);
      //           } else if (weekday.contains(dayName)) {
      //             // Add just open hours if day exists
      //             var index = weekday.indexOf(dayName) + dayName.length;
      //             weekday = '$weekday\n\t${daysOpenHours.substring(index)}';
      //             weekdaysText[i] = weekday;
      //           }
      //         }
      //       } else {
      //         weekdaysText.add(daysOpenHours);
      //       }
      //     }
      //   }
      //   for (var i = 0; i < openHours.periods.length; i++) {
      //     final dayIndex = openHours.periods[i].open.day;
      //     if (daysOfTheWeek[dayIndex] == todaysWeekDay) {
      //       from = openHours.periods[i].open.time;
      //       final fromSplit = from.split(':');
      //       print('Here: $from');
      //       final fromHour = int.tryParse(fromSplit[0]) ?? -1;
      //       final fromMinutes = int.tryParse(fromSplit[1]) ?? -1;
      //       var fromTime = DateTime(
      //         date.year,
      //         date.month,
      //         date.day,
      //         fromHour,
      //         fromMinutes,
      //       );
      //       to = openHours.periods[i].close.time;
      //       final toHour = int.tryParse(to.split(':')[0]) ?? -1;
      //       final toMinutes = int.tryParse(to.split(':')[1]) ?? -1;
      //       var toTime = DateTime(
      //         date.year,
      //         date.month,
      //         date.day,
      //         toHour,
      //         toMinutes,
      //       );
      //
      //       if (fromHour == -1 || fromMinutes == -1 || toHour == -1 || toMinutes == -1) {
      //         status = '';
      //       } else {
      //         if (toTime.isBefore(fromTime)) {
      //           if (date.isBefore(fromTime) && date.hour > 12) {
      //             toTime = toTime.add(const Duration(days: 1));
      //           } else if (date.isAfter(fromTime) && date.hour < 12) {
      //             fromTime = fromTime.subtract(const Duration(days: 1));
      //           }
      //         }
      //
      //         if (date.isAfter(fromTime) && date.isBefore(toTime)) {
      //           status = 'Open Now';
      //         }
      //       }
      //     }
      //   }
      // }
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
          // backgroundColor: context.theme.cardTheme.color,
          // surfaceTintColor: context.theme.cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 12.r),
          elevation: weekdaysText.isEmpty ? 0 : 2,
        ).copyWith(
          backgroundColor: MaterialStatePropertyAll(isFromDetailedPage && weekdaysText.isEmpty
              ? context.theme.colorScheme.background
              : context.theme.cardTheme.color),
          surfaceTintColor: MaterialStatePropertyAll(isFromDetailedPage && weekdaysText.isEmpty
              ? context.theme.colorScheme.background
              : context.theme.cardTheme.color),
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
