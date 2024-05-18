import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsOpenNowWidget extends StatelessWidget {
  const IsOpenNowWidget({
    required this.isOpenNow,
    required this.weekdayText,
    this.visible = true,
    this.iconSize = 16,
    this.fontSize = 12,
    super.key,
  });

  final double? iconSize;
  final bool visible;
  final bool isOpenNow;
  final double? fontSize;
  final List<String> weekdayText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible == true,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          surfaceTintColor: const MaterialStatePropertyAll(Colors.white),
          shape: weekdayText.isEmpty
              ? null
              : MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
          padding: weekdayText.isEmpty
              ? const MaterialStatePropertyAll(
                  EdgeInsets.zero,
                )
              : MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 12.r, horizontal: 12.r),
                ),
          elevation: weekdayText.isEmpty
              ? const MaterialStatePropertyAll(
                  0,
                )
              : const MaterialStatePropertyAll(
                  3,
                ),
        ),
        onPressed: weekdayText.isEmpty
            ? null
            : () => _displayHoursDialog(
                  context,
                ),
        icon: Icon(
          Icons.access_time,
          size: iconSize,
          color: isOpenNow ? Colors.green : Colors.red,
        ),
        label: Text(
          isOpenNow ? 'Open Now' : 'Closed',
          style: TextStyle(
            color: isOpenNow ? Colors.green : Colors.red,
            fontSize: fontSize?.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _displayHoursDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Hours',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
          ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < weekdayText.length; index++)
                  Row(
                    children: [
                      FittedBox(
                        child: Text(
                          weekdayText[index].replaceAll(
                            ', ',
                            '\n                     ',
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
        );
      },
    );
  }
}
