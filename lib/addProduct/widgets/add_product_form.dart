import 'dart:io';

import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/addProduct/widgets/add_product_form_image.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/product_provider.dart';
import 'package:sheveegan/widgets/input_text_field.dart';

class AddProductForm extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  String? barcode;
  String? productName;
  String? ingredients;

  final productScanResults = useProvider(productProvider.state);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AddProductFormImage(),
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
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Barcode is required';
                    }
                  },
                  onSaved: (String? value) {
                    barcode = value;
                    context.read(productProvider).state.barcode = barcode;
                  },
                  onChanged: (String? value) {
                    barcode = value;
                    print(barcode);
                    context.read(productProvider).state.barcode = barcode;
                  }),
              InputTextFormField(
                focusNode: new FocusNode(),
                initialValue: productScanResults.productName,
                labelText: 'Product Name',
                hintText: 'Enter Product Name',
                filled: true,
                fillColor: Colors.green.shade50,
                suffixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    context.read(productProvider).readProductNameFromImage();
                  },
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Product Name is required';
                  }
                },
                onSaved: (String? value) {
                  productName = value;
                  context.read(productProvider).state.productName = productName;
                },
                onChanged: (String? value) {
                  productName = value;
                  print(productName);
                  context.read(productProvider).state.productName = productName;
                },
              ),
              InputTextFormField(
                  focusNode: new FocusNode(),
                  initialValue: productScanResults.ingredients,
                  labelText: 'Ingredients',
                  hintText: "Enter Ingredients list",
                  filled: true,
                  fillColor: Colors.green.shade50,
                  suffixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      context.read(productProvider).readIngredientsFromImage();
                    },
                  ),
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
                    context.read(productProvider).state.ingredients =
                        ingredients;
                  },
                  onChanged: (String? value) {
                    ingredients = value;
                    print(ingredients);
                    context.read(productProvider).state.ingredients =
                        ingredients;
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Label",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Does it have a vegan label?",
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.w500,
                          // fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Theme(
                          data:
                              ThemeData(unselectedWidgetColor: Colors.white54),
                          child: Radio(
                            activeColor: Colors.white,
                            focusColor: Colors.white,
                            hoverColor: Colors.white,
                            value: 0,
                            groupValue:
                                context.read(productProvider).radioValue,
                            onChanged: (int? value) => context
                                .read(productProvider)
                                .setVeganLabel(value!),
                          ),
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Theme(
                          data:
                              ThemeData(unselectedWidgetColor: Colors.white54),
                          child: Radio(
                            activeColor: Colors.white,
                            focusColor: Colors.white,
                            hoverColor: Colors.white,
                            value: 1,
                            groupValue:
                                context.read(productProvider).radioValue,
                            onChanged: (int? value) => context
                                .read(productProvider)
                                .setVeganLabel(value!),
                          ),
                        ),
                        Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      style: TextStyle(color: primaryTextColor),
                    ),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.green.shade50),
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
                            barcode!, productName!, ingredients!);
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
}
