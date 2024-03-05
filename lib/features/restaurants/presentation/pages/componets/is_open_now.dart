import 'package:flutter/material.dart';

import '../../../domain/entities/restaurant_details.dart';

class IsOpenNowWidget extends StatelessWidget {
  const IsOpenNowWidget(
      {Key? key,
      required this.visible,
      required this.isOpenNow,
      this.iconSize = 16,
      this.fontSize = 12,
      required this.weekdayText})
      : super(key: key);
  final double? iconSize;
  final bool? visible;
  final bool isOpenNow;
  final double? fontSize;
  final List<String> weekdayText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible == true,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          shape: weekdayText.isEmpty
              ? null
              : MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
          padding: weekdayText.isEmpty
              ? MaterialStatePropertyAll(
                  EdgeInsets.zero,
                )
              : MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
          elevation: weekdayText.isEmpty ? MaterialStatePropertyAll(0) : MaterialStatePropertyAll(3),
        ),
        onPressed: weekdayText.isEmpty
            ? null
            : () {
                _displayHoursDialog(context);
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time,
              size: iconSize,
              color: isOpenNow ? Colors.green : Colors.red,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.005,
            ),
            Row(
              children: [
                Text(
                  isOpenNow ? "Open Now" : "Closed",
                  style: TextStyle(
                    color: isOpenNow ? Colors.green : Colors.red,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _displayHoursDialog(
    BuildContext context,
  ) async {
    for (int index = 0; index < weekdayText.length; index++) {
      print(weekdayText[index]);
    }
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Hours',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800, fontSize: 20),
          ),
          content: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 15),
                //   child: Text(
                //     'Hours',
                //     style: Theme.of(context)
                //         .textTheme
                //         .bodyMedium
                //         ?.copyWith(color: Colors.grey.shade800, fontSize: 24),
                //   ),
                // ),
                for (int index = 0; index < weekdayText.length; index++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          weekdayText[index].replaceAll(', ', '\n                     '),
                          style: TextStyle(color: Colors.grey.shade800, fontSize: 14, fontWeight: FontWeight.w600),
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
                'OK',
                style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(vertical: 5),
        );
      },
    );
  }
}
