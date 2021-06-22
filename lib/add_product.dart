import 'package:flutter/material.dart';
import 'package:sheveegan/colors.dart';

class AddProduct extends StatelessWidget {
  // const AddProduct({Key? key}) : super(key: key);

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
