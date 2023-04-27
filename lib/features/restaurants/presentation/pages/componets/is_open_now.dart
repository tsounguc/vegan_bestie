import 'package:flutter/material.dart';

class IsOpenNowWidget extends StatelessWidget {
  const IsOpenNowWidget(
      {Key? key, required this.visible, required this.isOpenNow, this.iconSize = 16, this.fontSize = 12})
      : super(key: key);
  final double? iconSize;
  final bool? visible;
  final bool isOpenNow;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible == true,
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
    );
  }
}
