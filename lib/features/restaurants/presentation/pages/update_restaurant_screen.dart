import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

import 'componets/update_restaurant_form.dart';

class UpdateRestaurantScreen extends StatefulWidget {
  const UpdateRestaurantScreen({super.key});

  static const String id = 'updateRestaurantScreen';

  @override
  State<UpdateRestaurantScreen> createState() => _UpdateRestaurantScreenState();
}

class _UpdateRestaurantScreenState extends State<UpdateRestaurantScreen> {
  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  bool get restaurantNameEntered => restaurantNameController.text.trim().isNotEmpty;

  bool get streetAddressEntered => streetAddressController.text.trim().isNotEmpty;

  bool get cityEntered => cityController.text.trim().isNotEmpty;

  bool get stateEntered => stateController.text.trim().isNotEmpty;

  bool get zipcodeEntered => zipcodeController.text.trim().isNotEmpty;

  bool get phoneNumberEntered => phoneNumberController.text.trim().isNotEmpty;

  bool get websiteEntered => websiteController.text.trim().isNotEmpty;

  bool get canSubmit =>
      restaurantNameEntered && streetAddressEntered && cityEntered && stateEntered ||
      zipcodeEntered ||
      phoneNumberEntered ||
      websiteEntered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(context.currentUser?.isAdmin == true ? 'Edit' : 'Suggest an edit'),
        centerTitle: true,
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
                        // child: pickedImage != null
                        //     ? Image.file(
                        //         pickedImage!,
                        //         fit: BoxFit.contain,
                        //       )
                        //     : widget.product != null && widget.product!.imageFrontUrl.isNotEmpty
                        //         ? Image.network(
                        //             widget.product!.imageFrontUrl,
                        //             fit: BoxFit.contain,
                        //           )
                        //         : Icon(
                        //             Icons.image_outlined,
                        //             color: Colors.grey.shade500,
                        //             size: 175,
                        //           ),
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
                          // await showProductImagePickerOptions(context);
                        },
                        icon: Icon(
                          // (pickedImage != null ||
                          //     (widget.product != null && widget.product!.imageFrontUrl.isNotEmpty))
                          //     ? Icons.edit
                          //     :
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              UpdateRestaurantForm(
                restaurantNameController: restaurantNameController,
                streetAddressController: streetAddressController,
                cityController: cityController,
                stateController: stateController,
                zipcodeController: zipcodeController,
                phoneNumberController: phoneNumberController,
                websiteController: websiteController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
