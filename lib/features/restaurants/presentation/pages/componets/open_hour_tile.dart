import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/period_widget.dart';

class OpenHourTile extends StatefulWidget {
  const OpenHourTile({
    required this.title,
    required this.periodControllers,
    this.value = false,
    this.onChanged,
    this.onAddButtonPressed,
    this.onRemoveButtonPressed,
    super.key,
  });

  final bool? value;
  final void Function(bool?)? onChanged;
  final void Function()? onAddButtonPressed;
  final void Function()? onRemoveButtonPressed;
  final String title;
  final List<PeriodItem> periodControllers;

  @override
  State<OpenHourTile> createState() => _OpenHourTileState();
}

class _OpenHourTileState extends State<OpenHourTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: widget.value,
                  fillColor:
                      MaterialStatePropertyAll(widget.value! ? context.theme.primaryColor : Colors.transparent),
                  onChanged: widget.onChanged,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: context.theme.textTheme.bodyMedium?.color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Open and closed time text for fields
            Column(
              children: [
                if (widget.value == false)
                  SizedBox(
                    child: Text(
                      'Closed',
                      style: TextStyle(
                        color: context.theme.textTheme.bodyMedium?.color,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  for (int i = 0; i < widget.periodControllers.length; i++)
                    PeriodWidget(
                      openTextEditingController: widget.periodControllers[i].openTextEditingController,
                      closeTextEditingController: widget.periodControllers[i].closeTextEditingController,
                      onOpenTap: () async {
                        final time = await selectTime(context);
                        if (time != null) {
                          widget.periodControllers[i].openTextEditingController.text =
                              '${time?.hour}:${time?.minute}';
                        }
                      },
                      onCloseTap: () async {
                        final time = await selectTime(context);
                        if (time != null) {
                          widget.periodControllers[i].closeTextEditingController.text =
                              '${time?.hour}:${time?.minute}';
                        }
                      },
                      onRemoveButtonPressed: () {
                        setState(() {
                          widget.periodControllers.removeAt(i);
                        });
                      },
                    ),
              ],
            ),

            Row(
              children: [
                Visibility(
                  visible: widget.value == true,
                  child: IconButton(
                    onPressed: widget.onAddButtonPressed,
                    icon: Icon(Icons.add),
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }
}
