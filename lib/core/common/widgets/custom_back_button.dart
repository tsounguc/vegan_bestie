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
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
              shape: const MaterialStatePropertyAll(
                CircleBorder(),
              ),
              minimumSize: const MaterialStatePropertyAll(Size(45, 45)),
              backgroundColor: MaterialStatePropertyAll(
                  widget.color != Colors.white
                      ? Colors.white
                      : Colors.transparent),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: widget.color,
            ),
            // label: Text(''),
          ),
        ),
      ],
    );
  }
}
