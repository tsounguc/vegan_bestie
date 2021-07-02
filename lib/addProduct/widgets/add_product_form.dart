import 'dart:io';

import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/productprovider.dart';
import 'package:sheveegan/widgets/input_text_field.dart';

class AddProductForm extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  String? barcode;
  String? productName;
  String? ingredients;

  AddProductForm(CameraDescription? firstCamera);

  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              productScanResults.imageToUpLoadPath!.isEmpty
                  ? Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          color: gradientStartColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(5, 7),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 200,
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.green.shade50,
                              // size: 50,
                            ),
                            onPressed: () {
                              print("image picker to add picture");
                              context.read(productProvider).showPicker(context);
                            },
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(5, 7),
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.file(
                          File(productScanResults.imageToUpLoadPath!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              SizedBox(
                height: 25,
              ),
              InputTextFormField(
                focusNode: new FocusNode(),
                initialValue: productScanResults.barcode,
                labelText: 'Barcode',
                hintText: 'Enter Barcode',
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Barcode is required';
                  }
                },
                onSaved: (String? value) {
                  barcode = value;
                },
              ),
              InputTextFormField(
                focusNode: new FocusNode(),
                initialValue: productScanResults.productName,
                labelText: 'Product Name',
                hintText: 'Enter Product Name',
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Product Name is required';
                  }
                },
                onSaved: (String? value) {
                  productName = value;
                },
              ),
              InputTextFormField(
                focusNode: new FocusNode(),
                initialValue: productScanResults.ingredients,
                labelText: 'Ingredients',
                hintText: "Enter Ingredients list",
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                minLines: 5,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Ingredients list is required';
                  }
                },
                onSaved: (String? value) {
                  ingredients = value;
                },
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        //
                        print("Please enter info");
                      } else {
                        _formKey.currentState!.save();
                        print(barcode);
                        print(productName);
                        print(ingredients);
                        context.read(productProvider).addNewProduct(
                            barcode!, productName!, ingredients!, productScanResults.imageToUpLoadPath! );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          color: gradientStartColor,
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(5, 7),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 200,
            icon: Icon(
              Icons.add_photo_alternate,
              color: Colors.green.shade50,
              // size: 50,
            ),
            onPressed: () {
              print("image picker to add picture");
            },
          ),
          // Text(
          //   "Take Photo",
          //   style: TextStyle(
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}
