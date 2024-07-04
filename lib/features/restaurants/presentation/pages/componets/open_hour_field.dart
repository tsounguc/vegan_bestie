import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class OpenHourField extends StatelessWidget {
  const OpenHourField({
    required this.controller,
    this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.15,
      height: context.width * 0.08,
      child: IField(
        controller: controller,
        borderRadius: BorderRadius.circular(10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5).copyWith(right: 0),
        onTap: onTap,
        fontSize: 12.r,
      ),
    );
  }
}
