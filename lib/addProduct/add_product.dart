import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/addProduct/widgets/add_product_form.dart';
import 'package:sheveegan/colors.dart';

class AddProduct extends HookWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gradientStartColor,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Add New Product', style: TextStyle(color: Colors.white),),
          elevation: 0,
          // toolbarHeight: 100,
          backgroundColor: gradientStartColor,
          leading: CloseButton(
            color: Colors.white,
          ),
        ),
        body: AddProductForm()
      ),
    );
  }
}
