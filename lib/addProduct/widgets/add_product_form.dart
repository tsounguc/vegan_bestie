import 'dart:io';

import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/addProduct/widgets/add_product_form_image.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/productprovider.dart';
import 'package:sheveegan/widgets/input_text_field.dart';

class AddProductForm extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  String? barcode;
  String? productName;
  String? ingredients;


  AddProductForm(CameraDescription? firstCamera);

  final productScanResults = useProvider(productProvider.state);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // if(barcode == null || barcode!.isEmpty)
    //   barcode = productScanResults.barcode;
    // if(productName == null || productName!.isEmpty)
    //   productName = productScanResults.productName;
    // if(ingredients == null || ingredients!.isEmpty)
    //   ingredients = productScanResults.ingredients;

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
                // controller: controller,
                labelText: 'Product Name',
                hintText: 'Enter Product Name',
                filled: true,
                fillColor: Colors.green.shade50,
                suffixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    //Todo: read product name list from picture and put results in the textfield;
                    context.read(productProvider).getProductNameFromImage();
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
                  // controller.text = value!;
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
                    //Todo: read ingredient list from picture and put results in the textfield;
                    context.read(productProvider).getIngredientsFromImage();
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
                // onChanged: (String ? value){
                //   ingredients = value;
                //   context.read(productProvider).setIngredients(value);
                // },
                onSaved: (String? value) {
                  ingredients = value;
                  context.read(productProvider).setIngredients(value);
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
