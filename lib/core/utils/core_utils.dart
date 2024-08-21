import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/widgets/enter_password_dialog.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(
    BuildContext context,
    String message, {
    int durationInMilliSecond = 3000,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(milliseconds: durationInMilliSecond),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          backgroundColor: context.theme.colorScheme.background,
        ),
      ),
    );
  }

  static void displayDeleteAccountWarning(BuildContext context, {void Function()? onDeletePressed}) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.yellow[600],
          backgroundColor: context.theme.cardTheme.color,
          surfaceTintColor: context.theme.cardTheme.color,
          title: Text(
            'WARNING',
            style: context.theme.textTheme.titleMedium,
          ),
          content: Text(
            'Are you sure you want to delete this account?',
            style: context.theme.textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: context.theme.textTheme.bodyMedium,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: onDeletePressed,
              child: Text(
                'DELETE ACCOUNT',
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showEnterPasswordDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: serviceLocator<AuthBloc>(),
          child: const EnterPasswordDialog(),
        );
      },
    );
  }

  static void displayHoursDialog(
    BuildContext context,
    List<Period> openHourPeriods,
  ) async {
    final date = DateTime.now();
    final df = DateFormat.jm();
    final todaysWeekDay = DateFormat('EEEE').format(date).toLowerCase().capitalizeFirstLetter();
    final isOpen = checkOpenStatus(context, openHourPeriods) == 'Open Now';
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.theme.cardTheme.color,
          surfaceTintColor: context.theme.cardTheme.color,
          title: Center(
            child: Text(
              'Hours',
              style: context.theme.textTheme.bodyMedium?.copyWith(
                // color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < context.daysOfTheWeek.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Weekday column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                context.daysOfTheWeek[index]!,
                                style: TextStyle(
                                  // color: context.daysOfTheWeek[index] == todaysWeekDay && isOpen
                                  //     ? Colors.green
                                  //     : null,
                                  fontSize: 12.sp,
                                  fontWeight: context.daysOfTheWeek[index] == todaysWeekDay
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Open hours of the weekdays
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final period in openHourPeriods)
                              if (period.open.day == index &&
                                  period.open.time.isNotEmpty &&
                                  period.close.time.isNotEmpty)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${df.format(
                                        DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          int.tryParse(period.open.time.split(':')[0]) ?? -1,
                                          int.tryParse(period.open.time.split(':')[1]) ?? -1,
                                        ),
                                      )} - ${df.format(
                                        DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          int.tryParse(period.close.time.split(':')[0]) ?? -1,
                                          int.tryParse(period.close.time.split(':')[1]) ?? -1,
                                        ),
                                      )}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: context.daysOfTheWeek[index] == todaysWeekDay
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )
                              else if (period.open.day == index &&
                                  (period.open.time.isEmpty || period.close.time.isEmpty))
                                Row(
                                  children: [
                                    Text(
                                      'Closed',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: context.daysOfTheWeek[index] == todaysWeekDay
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
        );
      },
    );
  }

  static String checkOpenStatus(BuildContext context, List<Period> openHoursPeriods) {
    var status = 'Closed';
    final today = DateTime.now();
    var from = '';
    var to = '';
    final todaysWeekDay = DateFormat('EEEE').format(today).toLowerCase().capitalizeFirstLetter();

    final daysOfTheWeek = context.daysOfTheWeek;
    if (openHoursPeriods.isNotEmpty) {
      for (final period in openHoursPeriods) {
        // check if is open now
        if (daysOfTheWeek[period.open.day] == todaysWeekDay) {
          from = period.open.time;
          final fromSplit = from.split(':');
          final fromHour = from.isEmpty ? -1 : int.tryParse(fromSplit[0]) ?? -1;
          final fromMinutes = from.isEmpty ? -1 : int.tryParse(fromSplit[1]) ?? -1;
          var fromTime = DateTime(
            today.year,
            today.month,
            today.day,
            fromHour,
            fromMinutes,
          );

          to = period.close.time;
          final toHour = to.isEmpty ? -1 : int.tryParse(to.split(':')[0]) ?? -1;
          final toMinutes = to.isEmpty ? -1 : int.tryParse(to.split(':')[1]) ?? -1;
          var toTime = DateTime(
            today.year,
            today.month,
            today.day,
            toHour,
            toMinutes,
          );

          if (fromHour == -1 || fromMinutes == -1 || toHour == -1 || toMinutes == -1) {
            status = 'Closed';
          } else {
            if (toTime.isBefore(fromTime)) {
              if (today.isBefore(fromTime) && today.hour > 12) {
                toTime = toTime.add(const Duration(days: 1));
              } else if (today.isAfter(fromTime) && today.hour < 12) {
                fromTime = fromTime.subtract(const Duration(days: 1));
              }
            }

            if (today.isAfter(fromTime) && today.isBefore(toTime)) {
              status = 'Open Now';
            }
          }
        }
      }
    }
    return status;
  }

  static Future<File?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static Future<List<XFile>?> pickImagesFromGallery() async {
    final selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      return selectedImages;
    }
    return null;
  }

  static Future<File?> getImageFromCamera() async {
    final picker = ImagePicker();
    if (picker.supportsImageSource(ImageSource.camera)) {
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return File(image.path);
      }
      return null;
    }
    return null;
  }
}
