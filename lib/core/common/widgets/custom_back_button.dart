import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

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
        PopScope(
          onPopInvoked: (didPop) {
            try {
              context.pop();
            } catch (_) {
              if (Navigator.canPop(context)) {
                setState(() {
                  canPop = false;
                });
              } else {
                setState(() {
                  canPop = false;
                });
              }
            }
          },
          canPop: canPop,
          child: IconButton(
            onPressed: () {
              try {
                context.pop();
              } catch (_) {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: widget.color,
            ),
          ),
        ),
      ],
    );
  }
}
