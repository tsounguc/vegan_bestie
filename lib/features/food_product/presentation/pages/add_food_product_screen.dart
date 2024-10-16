import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/presentation/pages/refactors/add_product_form.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

class AddFoodProductScreen extends StatefulWidget {
  const AddFoodProductScreen({
    // required this.title,
    // required this.product,
    super.key,
  });

  // final String title;
  // final FoodProduct? product;

  static const String id = '/addFoodProductScreen';

  @override
  State<AddFoodProductScreen> createState() => _AddFoodProductScreenState();
}

class _AddFoodProductScreenState extends State<AddFoodProductScreen> {
  final barcodeController = TextEditingController();
  final productNameController = TextEditingController();
  final ingredientsController = TextEditingController();

  final proteinController = TextEditingController();

  final carbsController = TextEditingController();
  final fatsController = TextEditingController();
  File? pickedImage;

  bool get barcodeEntered => barcodeController.text.trim().isNotEmpty;

  bool get productNameEntered => productNameController.text.trim().isNotEmpty;

  bool get ingredientsEntered => ingredientsController.text.trim().isNotEmpty;

  bool get proteinEntered => proteinController.text.trim().isNotEmpty;

  bool get carbsEntered => carbsController.text.trim().isNotEmpty;

  bool get fatsEntered => fatsController.text.trim().isNotEmpty;

  bool get imageEntered => pickedImage != null;

  bool get canSubmit =>
      barcodeEntered &&
      productNameEntered &&
      ingredientsEntered &&
      proteinEntered &&
      carbsEntered &&
      fatsEntered &&
      imageEntered;

  void submitChanges(BuildContext context) {
    final bloc = BlocProvider.of<FoodProductCubit>(context);
    final nutriments = const NutrimentsModel.empty().copyWith(
      proteins100G: double.parse(proteinController.text),
      carbohydrates100G: double.tryParse(carbsController.text),
      fat100G: double.tryParse(
        fatsController.text,
      ),
    );
    final product = FoodProductModel.empty().copyWith(
      code: barcodeController.text,
      productName: productNameController.text,
      ingredientsText: ingredientsController.text,
      nutriments: nutriments,
    );

    bloc.addFoodProduct(
      foodProduct: product,
      productImage: pickedImage!,
    );
  }

  @override
  void initState() {
    barcodeController.text = '';
    productNameController.text = '';
    ingredientsController.text = '';
    proteinController.text = '';
    carbsController.text = '';
    fatsController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    barcodeController.dispose();
    productNameController.dispose();
    ingredientsController.dispose();
    super.dispose();
  }

  Future<void> showProductImagePickerOptions(BuildContext context) async {
    final image = await CoreUtils.pickImageFromGallery();
    setState(() {
      pickedImage = image;
    });
  }

  Future<void> showIngredientsImagePickerOptions(BuildContext context) async {
    final File? pickedIngredientsImage = await CoreUtils.pickImageFromGallery();

    if (context.mounted) {
      if (pickedIngredientsImage != null) {
        await BlocProvider.of<FoodProductCubit>(
          context,
        ).readIngredientsFromImage(pickedIngredientsImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodProductCubit, FoodProductState>(
      listener: (context, state) {
        if (state is FoodProductUploaded) {
          CoreUtils.showSnackBar(context, 'Product uploaded');
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
        } else if (state is FoodProductError) {
          CoreUtils.showSnackBar(context, state.message);
        }

        if (state is IngredientsRead) {
          ingredientsController.text = state.ingredients;
          debugPrint(state.ingredients);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // surfaceTintColor: Colors.white,
            leading: const CustomBackButton(),
            title: const Text('Add Product'),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                shrinkWrap: true,
                children: [
                  Builder(
                    builder: (context) {
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(height: 25.h),
                          Container(
                            height: context.height * 0.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    fit: BoxFit.contain,
                                  )
                                : Icon(
                                    Icons.image_outlined,
                                    color: Colors.grey.shade500,
                                    size: 175,
                                  ),
                          ),
                          Positioned(
                            child: Container(
                              height: context.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                color: Colors.grey.shade600.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showProductImagePickerOptions(context);
                            },
                            icon: Icon(
                              pickedImage != null ? Icons.edit : Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  AddProductForm(
                    barcodeController: barcodeController,
                    productNameController: productNameController,
                    ingredientsController: ingredientsController,
                    proteinController: proteinController,
                    carbsController: carbsController,
                    fatsController: fatsController,
                    onReadIngredientsFromImage: () async {
                      await showIngredientsImagePickerOptions(context);
                    },
                  ),
                  StatefulBuilder(
                    builder: (context, refresh) {
                      barcodeController.addListener(() => refresh(() {}));
                      productNameController.addListener(() => refresh(() {}));
                      ingredientsController.addListener(() => refresh(() {}));
                      proteinController.addListener(() => refresh(() {}));
                      carbsController.addListener(() => refresh(() {}));
                      fatsController.addListener(() => refresh(() {}));
                      return state is UploadingFoodProduct
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: !canSubmit
                                  ? null
                                  : () => submitChanges(
                                        context,
                                      ),
                              label: 'Submit',
                              backgroundColor: !canSubmit
                                  ? Colors.grey
                                  : Theme.of(
                                      context,
                                    ).buttonTheme.colorScheme?.primary,
                              textColor: Colors.white,
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
