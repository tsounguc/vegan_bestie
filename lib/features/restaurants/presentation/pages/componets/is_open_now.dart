import 'package:flutter/material.dart';

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
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: weekdayText.isEmpty
              ? null
              : MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
          padding: weekdayText.isEmpty
              ? const MaterialStatePropertyAll(
                  EdgeInsets.zero,
                )
              : const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
        child: Row(
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
                  isOpenNow ? 'Open Now' : 'Closed',
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

  Future<void> _displayHoursDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Hours',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade800,
                  fontSize: 20,
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
                            color: Colors.grey.shade800,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
                'OK',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(vertical: 5),
        );
      },
    );
  }
}
