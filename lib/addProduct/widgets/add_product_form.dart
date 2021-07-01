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

  @override
  Widget build(BuildContext context) {
    final productScanResults = useProvider(productProvider.state);
    return Container(
      margin: EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Expanded(child: imageProfile()),
            SizedBox(
              height: 50,
            ),
            InputTextFormField(
              initialValue: productScanResults.barcode,
              labelText: 'Barcode',
              // hintText: 'Enter Barcode',
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
              initialValue: productScanResults.productName,
              labelText: 'Product Name',
              // hintText: 'Enter Product Name',
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
              initialValue: productScanResults.ingredients,
              labelText: 'Ingredients',
              // hintText: "Enter Ingredients list",
              minLines: 5,
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
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
              height: 100,
            ),
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
                  context
                      .read(productProvider)
                      .addNewProduct(barcode!, productName!, ingredients!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: gradientStartColor,
          child: Icon(
            Icons.image_outlined,
            color: Colors.white,
            size: 100,
          ),
        ),
        Positioned(
          bottom: 5.0,
          right: 0,
          child: IconButton(iconSize: 30,
            icon: Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
