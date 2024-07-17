import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/open_hour_field.dart';

class PeriodWidget extends StatelessWidget {
  const PeriodWidget({
    required this.openTextEditingController,
    required this.closeTextEditingController,
    this.onOpenTap,
    this.onCloseTap,
    this.onRemoveButtonPressed,
    super.key,
  });

  final TextEditingController openTextEditingController;
  final TextEditingController closeTextEditingController;
  final void Function()? onOpenTap;
  final void Function()? onCloseTap;
  final void Function()? onRemoveButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            OpenHourField(
              controller: openTextEditingController,
              onTap: onOpenTap,
            ),
            const SizedBox(width: 8),
            const Text('-'),
            const SizedBox(width: 8),
            OpenHourField(
              controller: closeTextEditingController,
              onTap: onCloseTap,
            ),
            CloseButton(
              onPressed: onRemoveButtonPressed,
              style: const ButtonStyle(
                iconColor: MaterialStatePropertyAll(Colors.black54),
                iconSize: MaterialStatePropertyAll(20),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
