import 'dart:io';

import 'package:flutter/cupertino.dart';
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
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.only(left: 6),
              shape: const CircleBorder(),
              // minimumSize: const Size(45, 45),
              backgroundColor: widget.color != Colors.white
                  ? Colors.white
                  : Colors.transparent,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: widget.color,
            ),
            label: const Text(''),
          ),
        ),
      ],
    );
  }
}
