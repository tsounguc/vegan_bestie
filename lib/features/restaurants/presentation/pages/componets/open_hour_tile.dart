import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/app/providers/theme_inherited_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/period_widget.dart';

class OpenHourTile extends StatefulWidget {
  const OpenHourTile({
    required this.title,
    required this.periodControllers,
    this.value = false,
    this.onChanged,
    this.onAddButtonPressed,
    super.key,
  });

  final bool value;
  final void Function(bool?)? onChanged;
  final void Function()? onAddButtonPressed;
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
                Theme(
                  data: ThemeData.dark().copyWith(
                    unselectedWidgetColor:
                        true == ThemeSwitcher.of(context)?.isDarkModeOn ? Colors.white : Colors.black,
                  ),
                  child: Checkbox(
                    value: widget.value,
                    tristate: true,
                    checkColor: Colors.white,
                    fillColor:
                        MaterialStatePropertyAll(widget.value ? context.theme.primaryColor : Colors.transparent),
                    onChanged: widget.onChanged,
                  ),
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
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                        }
                      },
                      onCloseTap: () async {
                        final time = await selectTime(context);
                        if (time != null) {
                          widget.periodControllers[i].closeTextEditingController.text =
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
                    icon: Icon(
                      Icons.add,
                      color: context.theme.iconTheme.color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }
}
