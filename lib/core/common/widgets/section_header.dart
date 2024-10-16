import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/app/providers/theme_inherited_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.sectionTitle,
    required this.seeAll,
    required this.onSeeAll,
    this.fontSize,
    super.key,
  });

  final String sectionTitle;
  final bool seeAll;
  final VoidCallback onSeeAll;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeSwitcher.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: fontSize ?? 14.sp,
            fontWeight: FontWeight.w600,
            // color: true == themeMode.isDarkModeOn ? Colors.white : Colors.grey.shade800,
          ),
        ),
        if (seeAll)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: onSeeAll,
            child: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.theme.primaryColor,
                fontSize: 12.sp,
              ),
            ),
          ),
      ],
    );
  }
}
