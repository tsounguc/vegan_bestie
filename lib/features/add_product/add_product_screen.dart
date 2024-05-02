import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/add_product/widgets/add_product_form.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    required this.title,
    required this.product,
    super.key,
  });

  final String title;
  final FoodProduct? product;

  static const String id = '/addProductPage';

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final barcodeController = TextEditingController();
  final productNameController = TextEditingController();
  final ingredientsController = TextEditingController();
  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get barcodeChanged =>
      barcodeController.text
          .trim()
          .isNotEmpty;

  bool get productNameChanged =>
      productNameController.text
          .trim()
          .isNotEmpty;

  bool get ingredientsChanged =>
      ingredientsController.text
          .trim()
          .isNotEmpty;

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged => !barcodeChanged && !productNameChanged && !ingredientsChanged && !imageChanged;

  void submitChanges(BuildContext context) {
    // if(nothingChanged)
    Navigator.pop(context);
  }

  @override
  void initState() {
    barcodeController.text = widget.product?.code ?? '';
    productNameController.text = widget.product?.productName ?? '';
    ingredientsController.text = widget.product?.ingredientsText ?? '';
    super.initState();
  }

  @override
  void dispose() {
    barcodeController.dispose();
    productNameController.dispose();
    ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScanProductCubit, ScanProductState>(
      listener: (context, state) {
        if (state is ProductUploaded) {
          Navigator.of(context).pop();
          CoreUtils.showSnackBar(context, 'Product uploaded');
        } else if (state is FoodProductError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
            elevation: 0,
            leading: const CloseButton(
              color: Colors.white,
            ),
          ),
          body: Column(
            children: [
              AddProductForm(
                barcodeController: barcodeController,
                productNameController: productNameController,
                ingredientsController: ingredientsController,
              ),
              const SizedBox(height: 30),
              StatefulBuilder(
                builder: (context, refresh) {
                  return state is UploadingProduct
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LongButton(
                        label: 'Submit',
                        onPressed: nothingChanged ? null : () => submitChanges(context),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddProductPageArguments {
  const AddProductPageArguments(this.title, this.product);

  final String title;
  final FoodProduct? product;
}
