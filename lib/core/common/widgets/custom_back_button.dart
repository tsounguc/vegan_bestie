import 'dart:io';

import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color color;

  const CustomBackButton({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: color,
          ),
        ),
      ],
    );
  }
}
