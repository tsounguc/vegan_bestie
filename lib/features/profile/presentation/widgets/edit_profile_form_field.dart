import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    required this.fieldTitle,
    required this.controller,
    this.hintText,
    this.borderRadius,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
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
          textInputAction: textInputAction,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
