import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MacroNutrientWidget extends StatelessWidget {
  final double percentage;
  final String title;
  final Widget icon;
  final Color color;
  final double? per100G;

  const MacroNutrientWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.percentage,
      required this.color,
      required this.per100G})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: icon
            // child: Icon(icon, color: color),
            ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title + " (${(percentage * 100).toStringAsFixed(1)}%)",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    " ${per100G?.toStringAsFixed(1) ?? "0.0"} g",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: percentage,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
        )
      ],
    );
  }
}
