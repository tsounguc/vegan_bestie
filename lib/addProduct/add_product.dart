import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/addProduct/widgets/add_product_form.dart';
import 'package:sheveegan/colors.dart';

class AddProduct extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: gradientStartColor,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Add New Product', style: TextStyle(color: Colors.white),),
            elevation: 0,
            backgroundColor: gradientStartColor,
            leading: CloseButton(
              color: Colors.white,
            ),
          ),
          body: AddProductForm()
        ),
      ),
    );
  }
}
