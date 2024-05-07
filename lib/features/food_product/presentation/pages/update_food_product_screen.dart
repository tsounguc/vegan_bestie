import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/enums/update_food_product.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/presentation/pages/refactors/add_product_form.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/home_page.dart';

class UpdateFoodProductScreen extends StatefulWidget {
  const UpdateFoodProductScreen({
    required this.title,
    required this.product,
    super.key,
  });

  final String title;
  final FoodProduct? product;

  static const String id = '/updateFoodProductScreen';

  @override
  State<UpdateFoodProductScreen> createState() => _UpdateFoodProductScreenState();
}

class _UpdateFoodProductScreenState extends State<UpdateFoodProductScreen> {
  final barcodeController = TextEditingController();
  final productNameController = TextEditingController();
  final ingredientsController = TextEditingController();

  final proteinController = TextEditingController();

  final carbsController = TextEditingController();
  final fatsController = TextEditingController();
  File? pickedImage;

  Future<void> pickImage() async {
    pickedImage = await CoreUtils.pickImageFromGallery();
  }

  bool get barcodeChanged => widget.product!.code != barcodeController.text.trim();

  bool get productNameChanged =>
      widget.product!.productName.capitalizeFirstLetter() != productNameController.text.trim();

  bool get ingredientsChanged =>
      widget.product!.ingredientsText.toLowerCase().capitalizeEveryWord(', ').capitalizeEveryWord(' (') !=
      ingredientsController.text.trim();

  bool get proteinChanged => widget.product!.nutriments.proteins100G.toString() != proteinController.text.trim();

  bool get carbsChanged => widget.product!.nutriments.carbohydrates100G.toString() != carbsController.text.trim();

  bool get fatsChanged => widget.product!.nutriments.fat100G.toString() != fatsController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !barcodeChanged &&
      !productNameChanged &&
      !ingredientsChanged &&
      !proteinChanged &&
      !carbsChanged &&
      !fatsChanged &&
      !imageChanged;

  void submitChanges(BuildContext context) {
    final bloc = BlocProvider.of<FoodProductCubit>(context);
    if (imageChanged) {
      bloc.updateFoodProduct(
        action: UpdateFoodAction.imageFrontUrl,
        foodData: pickedImage,
        foodProduct: widget.product!,
      );
    }
    if (productNameChanged) {
      bloc.updateFoodProduct(
        action: UpdateFoodAction.productName,
        foodData: productNameController.text,
        foodProduct: widget.product!,
      );
    }
    if (ingredientsChanged) {
      bloc.updateFoodProduct(
        action: UpdateFoodAction.ingredients,
        foodData: ingredientsController.text,
        foodProduct: widget.product!,
      );
    }
    if (proteinChanged) {
      bloc.updateFoodProduct(
        action: UpdateFoodAction.protein,
        foodData: proteinController.text,
        foodProduct: widget.product!,
      );
    }
    if (carbsChanged) {
      bloc.updateFoodProduct(
        action: UpdateFoodAction.carbs,
        foodData: carbsController.text,
        foodProduct: widget.product!,
      );
    }
    if (fatsChanged) {
      bloc.updateFoodProduct(
        action: UpdateFoodAction.fats,
        foodData: fatsController.text,
        foodProduct: widget.product!,
      );
    }
  }

  @override
  void initState() {
    barcodeController.text = widget.product!.code ?? '';
    productNameController.text = widget.product!.productName.capitalizeFirstLetter() ?? '';
    ingredientsController.text =
        widget.product!.ingredientsText.toLowerCase().capitalizeEveryWord(', ').capitalizeEveryWord(' (') ?? '';
    proteinController.text = widget.product?.nutriments.proteins100G.toString() ?? '';
    carbsController.text = widget.product?.nutriments.carbohydrates100G.toString() ?? '';
    fatsController.text = widget.product?.nutriments.fat100G.toString() ?? '';
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
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(
                'Camera',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await CoreUtils.getImageFromCamera();

                setState(() {
                  pickedImage = image;
                });
              },
            ),
            SizedBox(
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: const Icon(
                Icons.image_outlined,
              ),
              title: Text(
                'Gallery',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await CoreUtils.pickImageFromGallery();

                setState(() {
                  pickedImage = image;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showIngredientsImagePickerOptions(BuildContext context) async {
    File? pickedIngredientsImage;
    await showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 10,
              ),
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(
                'Camera',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                pickedIngredientsImage = await CoreUtils.getImageFromCamera();
                Navigator.of(context).pop();
                if (pickedIngredientsImage != null) {
                  await BlocProvider.of<FoodProductCubit>(
                    context,
                  ).readIngredientsFromImage(pickedIngredientsImage!);
                }
              },
            ),
            SizedBox(
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              leading: const Icon(
                Icons.image_outlined,
              ),
              title: Text(
                'Gallery',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                pickedIngredientsImage = await CoreUtils.pickImageFromGallery();
                Navigator.of(context).pop();
                if (pickedIngredientsImage != null) {
                  await BlocProvider.of<FoodProductCubit>(
                    context,
                  ).readIngredientsFromImage(pickedIngredientsImage!);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodProductCubit, FoodProductState>(
      listener: (context, state) {
        if (state is FoodProductUploaded) {
          if (context.userProvider.user != null &&
              context.userProvider.user!.savedProductsBarcodes!.contains(widget.product!.code)) {
            final savedBarcodes = context.userProvider.user!.savedProductsBarcodes!;

            context.savedProductsProvider.savedProductsList = null;
            BlocProvider.of<FoodProductCubit>(
              context,
            ).fetchProductsList(savedBarcodes);
          }
        } else if (state is FoodProductError) {
          CoreUtils.showSnackBar(context, state.message);
        }

        if (state is IngredientsRead) {
          ingredientsController.text = state.ingredients;
          debugPrint(state.ingredients);
        }

        if (state is SavedProductsListFetched) {
          context.savedProductsProvider.savedProductsList = state.savedProductsList;
          CoreUtils.showSnackBar(context, 'Product uploaded');
          Navigator.popUntil(
            context,
            ModalRoute.withName(HomePage.id),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            leading: const CustomBackButton(
              color: Colors.black,
            ),
            title: Text(widget.title),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    fit: BoxFit.contain,
                                  )
                                : widget.product != null && widget.product!.imageFrontUrl.isNotEmpty
                                    ? Image.network(
                                        widget.product!.imageFrontUrl,
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
                              (pickedImage != null ||
                                      (widget.product != null && widget.product!.imageFrontUrl.isNotEmpty))
                                  ? Icons.edit
                                  : Icons.add_a_photo,
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
                      return state is UploadingFoodProduct || state is FetchingProductsList
                          ? const Center(child: CircularProgressIndicator())
                          : LongButton(
                              onPressed: nothingChanged
                                  ? null
                                  : () => submitChanges(
                                        context,
                                      ),
                              label: 'Submit',
                              backgroundColor: nothingChanged
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
