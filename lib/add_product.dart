import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/colors.dart';

class AddProduct extends HookWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: gradientStartColor,
        leading: CloseButton(color: Colors.white,),
      ),
    );
  }
}
