import 'package:flutter/material.dart';
import 'package:sheveegan/features/food_product/presentation/pages/widgets/add_product_form_field.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    required this.barcodeController,
    required this.productNameController,
    required this.ingredientsController,
    required this.proteinController,
    required this.carbsController,
    required this.fatsController,
    this.onReadIngredientsFromImage,
    super.key,
  });

  final TextEditingController barcodeController;
  final TextEditingController productNameController;

  final TextEditingController proteinController;
  final TextEditingController carbsController;
  final TextEditingController fatsController;
  final TextEditingController ingredientsController;
  final void Function()? onReadIngredientsFromImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddProductFormField(
          hintText: barcodeController.text.isNotEmpty ? barcodeController.text : 'Enter barcode',
          fieldTitle: 'Barcode',
          controller: barcodeController,
        ),
        AddProductFormField(
          hintText: productNameController.text.isNotEmpty ? productNameController.text : 'Enter product name',
          fieldTitle: 'Product Name',
          controller: productNameController,
        ),
        const Text(
          'Macros',
          style: TextStyle(),
        ),
        SizedBox(
          height: 20,
        ),
        AddProductFormField(
          hintText: proteinController.text.isNotEmpty ? proteinController.text : 'Enter protein',
          fieldTitle: 'Protein',
          controller: proteinController,
        ),
        AddProductFormField(
          hintText: carbsController.text.isNotEmpty ? carbsController.text : 'Enter carbs',
          fieldTitle: 'Carbs',
          controller: carbsController,
        ),
        AddProductFormField(
          hintText: fatsController.text.isNotEmpty ? fatsController.text : 'Enter fats',
          fieldTitle: 'Fats',
          controller: fatsController,
        ),
        AddProductFormField(
          hintText: ingredientsController.text.isNotEmpty ? ingredientsController.text : 'Enter ingredients',
          fieldTitle: 'Ingredients',
          controller: ingredientsController,
          borderRadius: BorderRadius.circular(20),
          showTrailingButton: true,
          minLines: 4,
          maxLines: null,
          onTrailingButtonPressed: onReadIngredientsFromImage,
          textInputAction: TextInputAction.send,
        ),
      ],
    );
  }
}
