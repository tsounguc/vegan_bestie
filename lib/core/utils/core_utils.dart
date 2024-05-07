import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Future<File?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
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
  }
}
