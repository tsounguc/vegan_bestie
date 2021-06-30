import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
              onPressed: (){
                if (!_formKey.currentState!.validate())
                  {
                    //
                    print("Please enter info");
                  }else{
                  _formKey.currentState!.save();
                  print(barcode);
                  print(productName);
                  print(ingredients);
                  context.read(productProvider).addNewProduct(barcode!, productName!, ingredients!);
                }



              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcode(BuildContext context) {
    return InputTextFormField(
      initialValue: context.read(productProvider).barcode,
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
    );
  }

  Widget _buildProductName(BuildContext context) {
    return InputTextFormField(
      initialValue: context.read(productProvider).productName,
      // != null ? context.read(productProvider).productName : "",
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
    );
  }

  Widget _buildIngredients(BuildContext context) {
    return InputTextFormField(
      initialValue: context.read(productProvider).ingredientsText != null
          ? context.read(productProvider).ingredientsText
          : "",
      labelText: 'Ingredients',
      // hintText: "Enter Ingredients list",
      minLines: 5,
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Ingredients is required';
        }
      },
      onSaved: (String? value) {
        ingredients = value;
      },
    );
  }
}
