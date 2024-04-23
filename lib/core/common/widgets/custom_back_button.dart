import 'dart:io';

import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({super.key, this.color = Colors.white});

  final Color color;

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  bool canPop = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}
