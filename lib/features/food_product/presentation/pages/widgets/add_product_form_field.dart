import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';

class AddProductFormField extends StatelessWidget {
  const AddProductFormField({
    required this.fieldTitle,
    required this.controller,
    this.hintText,
    this.borderRadius,
    this.readOnly = false,
    this.showTrailingButton = false,
    this.maxLines = 1,
    this.minLines,
    this.onFieldSubmitted,
    this.onTrailingButtonPressed,
    this.textInputAction,
    super.key,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final bool showTrailingButton;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTrailingButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                fieldTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            if (showTrailingButton)
              ElevatedButton.icon(
                onPressed: onTrailingButtonPressed,
                icon: Icon(Icons.add_a_photo, color: Colors.grey.shade800),
                label: Text(
                  'Read from Image',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        IField(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
          borderRadius: borderRadius,
          maxLines: maxLines,
          minLines: minLines,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
