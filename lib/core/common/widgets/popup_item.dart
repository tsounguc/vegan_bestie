import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class PopupItem extends StatelessWidget {
  const PopupItem({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: context.theme.textTheme.titleSmall?.color,
          ),
        ),
        icon,
      ],
    );
  }
}
