import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message) {
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
    final textController = TextEditingController();
    final bloc = BlocProvider.of<AuthBloc>(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.yellow[600],
          backgroundColor: context.theme.cardTheme.color,
          surfaceTintColor: context.theme.cardTheme.color,
          title: Text(
            'Enter Password',
            style: context.theme.textTheme.titleMedium,
          ),
          content: IField(
            controller: textController,
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
              child: const Text(
                'DELETE ACCOUNT',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                // final navigator = Navigator.of(context);
                bloc.add(
                  DeleteAccountEvent(
                    password: textController.text.trim(),
                  ),
                );
                context.savedProductsProvider.savedProductsList = null;
                context.savedRestaurantsProvider.savedRestaurantsList = null;
              },
            ),
          ],
        );
      },
    );
  }

  static void displayHoursDialog(
    BuildContext context,
    List<String> weekdayText,
  ) async {
    final date = DateTime.now();
    final todaysWeekDay = DateFormat('EEEE').format(date).toLowerCase().capitalizeFirstLetter();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.theme.cardTheme.color,
          surfaceTintColor: context.theme.cardTheme.color,
          title: Text(
            'Hours',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              // color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < weekdayText.length; index++)
                  Row(
                    children: [
                      FittedBox(
                        child: Text(
                          weekdayText[index].replaceAll(
                            ', ',
                            '\n                     ',
                          ),
                          style: TextStyle(
                            // color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: weekdayText[index].split(' ')[0] == todaysWeekDay
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
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
                  fontWeight: FontWeight.w600,
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
