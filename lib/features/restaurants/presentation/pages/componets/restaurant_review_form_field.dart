import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';

class RestaurantReviewFormField extends StatelessWidget {
  const RestaurantReviewFormField({
    required this.fieldTitle,
    required this.controller,
    this.hintText,
    this.borderRadius,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    super.key,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        IField(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
          borderRadius: borderRadius,
          maxLines: maxLines,
          minLines: minLines,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
