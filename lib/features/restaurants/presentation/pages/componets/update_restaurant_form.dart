import 'package:flutter/material.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/update_restaurant_form_field.dart';

class UpdateRestaurantForm extends StatelessWidget {
  const UpdateRestaurantForm({
    required this.restaurantNameController,
    required this.streetAddressController,
    required this.phoneNumberController,
    required this.cityController,
    required this.stateController,
    required this.zipcodeController,
    required this.websiteController,
    // this.onReadIngredientsFromImage,
    super.key,
  });

  final TextEditingController restaurantNameController;
  final TextEditingController streetAddressController;

  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipcodeController;
  final TextEditingController phoneNumberController;
  final TextEditingController websiteController;

  // final void Function()? onReadIngredientsFromImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpdateRestaurantFormField(
          hintText: restaurantNameController.text.isNotEmpty ? restaurantNameController.text : 'Enter name',
          fieldTitle: 'Name',
          controller: restaurantNameController,
        ),
        UpdateRestaurantFormField(
          hintText: streetAddressController.text.isNotEmpty ? streetAddressController.text : 'Enter street addrss',
          fieldTitle: 'Street Address',
          controller: streetAddressController,
        ),
        UpdateRestaurantFormField(
          hintText: cityController.text.isNotEmpty ? cityController.text : 'Enter city',
          fieldTitle: 'City',
          controller: cityController,
        ),
        UpdateRestaurantFormField(
          hintText: stateController.text.isNotEmpty ? stateController.text : 'Enter state',
          fieldTitle: 'State',
          controller: stateController,
        ),
        UpdateRestaurantFormField(
          hintText: zipcodeController.text.isNotEmpty ? zipcodeController.text : 'Enter zipcode',
          fieldTitle: 'Zipcode (Optional)',
          controller: zipcodeController,
        ),
        UpdateRestaurantFormField(
          hintText: phoneNumberController.text.isNotEmpty ? phoneNumberController.text : 'Enter phone number',
          fieldTitle: 'Phone number (Optional)',
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        UpdateRestaurantFormField(
          hintText: websiteController.text.isNotEmpty ? websiteController.text : 'Enter Website',
          fieldTitle: 'Website (Optional)',
          controller: websiteController,
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }
}
