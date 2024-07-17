import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
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
    required this.descriptionController,
    required this.veganStatus,
    required this.hasVeganOptions,
    required this.veganStatusExpansionController,
    required this.adminList,
    this.onChangedIsVeganNo,
    this.onChangedIsVeganYes,
    this.onChangedHasVeganOptionsNo,
    this.onChangedHasVeganOptionsYes,
    super.key,
  });

  final TextEditingController restaurantNameController;
  final TextEditingController streetAddressController;

  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipcodeController;
  final TextEditingController phoneNumberController;
  final TextEditingController websiteController;

  final TextEditingController descriptionController;
  final bool? veganStatus;
  final bool? hasVeganOptions;
  final void Function(bool?)? onChangedIsVeganNo;
  final void Function(bool?)? onChangedIsVeganYes;
  final void Function(bool?)? onChangedHasVeganOptionsNo;
  final void Function(bool?)? onChangedHasVeganOptionsYes;
  final ExpansionTileController veganStatusExpansionController;
  final List<Widget> adminList;

  // final void Function()? onReadIngredientsFromImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: context.theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: veganStatus == false,
            controller: veganStatusExpansionController,
            iconColor: context.theme.iconTheme.color,
            collapsedIconColor: context.theme.iconTheme.color,
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 25,
            ),
            title: Text(
              'Is this a vegan business?',
              style: TextStyle(
                color: context.theme.textTheme.bodyMedium?.color,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Theme(
              data: context.theme.copyWith(
                unselectedWidgetColor: context.theme.iconTheme.color,
              ),
              child: Column(
                children: <Widget>[
                  RadioListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    title: Text(
                      'Yes',
                      style: TextStyle(
                        color: context.theme.textTheme.bodyMedium?.color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    value: true,
                    groupValue: veganStatus,
                    onChanged: onChangedIsVeganYes,
                  ),
                  RadioListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    title: Text(
                      'No',
                      style: TextStyle(
                        color: context.theme.textTheme.bodyMedium?.color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    value: false,
                    groupValue: veganStatus,
                    onChanged: onChangedIsVeganNo,
                  ),
                ],
              ),
            ),
            trailing: const SizedBox(),
            enabled: false,
            children: [
              ListTile(
                title: Text(
                  'Does it have vegan options?',
                  style: TextStyle(
                    color: context.theme.textTheme.bodyMedium?.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                subtitle: Column(
                  children: <Widget>[
                    RadioListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      title: Text(
                        'Yes',
                        style: TextStyle(
                          color: context.theme.textTheme.bodyMedium?.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: true,
                      groupValue: hasVeganOptions,
                      onChanged: onChangedHasVeganOptionsNo,
                    ),
                    RadioListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      title: Text(
                        'No',
                        style: TextStyle(
                          color: context.theme.textTheme.bodyMedium?.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: false,
                      groupValue: hasVeganOptions,
                      onChanged: onChangedHasVeganOptionsNo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        UpdateRestaurantFormField(
          hintText: restaurantNameController.text.isNotEmpty ? restaurantNameController.text : 'Enter name',
          fieldTitle: 'Business Name',
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          controller: restaurantNameController,
        ),
        Theme(
          data: context.theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            collapsedBackgroundColor: context.theme.cardTheme.color,
            iconColor: context.theme.iconTheme.color,
            collapsedIconColor: context.theme.iconTheme.color,
            title: Text(
              'Where is it located?',
              style: TextStyle(
                color: context.theme.textTheme.bodyMedium?.color,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            tilePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              UpdateRestaurantFormField(
                hintText: streetAddressController.text.isNotEmpty
                    ? streetAddressController.text
                    : 'Enter Street Address',
                fieldTitle: 'Street Address',
                borderRadius: BorderRadius.circular(10),
                controller: streetAddressController,
              ),
              UpdateRestaurantFormField(
                hintText: cityController.text.isNotEmpty ? cityController.text : 'Enter City',
                fieldTitle: 'City',
                borderRadius: BorderRadius.circular(10),
                controller: cityController,
              ),
              UpdateRestaurantFormField(
                hintText: stateController.text.isNotEmpty ? stateController.text : 'Enter State',
                fieldTitle: 'State',
                borderRadius: BorderRadius.circular(10),
                controller: stateController,
              ),
              UpdateRestaurantFormField(
                hintText: zipcodeController.text.isNotEmpty ? zipcodeController.text : 'Enter Zipcode',
                fieldTitle: 'Zipcode (Optional)',
                controller: zipcodeController,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        UpdateRestaurantFormField(
          hintText:
              descriptionController.text.isNotEmpty ? descriptionController.text : 'Enter a brief description',
          fieldTitle: 'Description (Optional)',
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          titleFontWeight: FontWeight.bold,
          titleFontSize: 14.sp,
          controller: descriptionController,
          textInputAction: TextInputAction.next,
          maxLines: 4,
        ),
        SizedBox(height: 10.h),
        if (context.currentUser?.isAdmin ?? false) ...adminList,
        SizedBox(height: 10.h),
        Theme(
          data: context.theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            collapsedBackgroundColor: context.theme.cardTheme.color,
            iconColor: context.theme.iconTheme.color,
            collapsedIconColor: context.theme.iconTheme.color,
            title: Text(
              'Phone Number and Website (Optional)',
              style: TextStyle(
                color: context.theme.textTheme.bodyMedium?.color,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            tilePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              UpdateRestaurantFormField(
                hintText:
                    phoneNumberController.text.isNotEmpty ? phoneNumberController.text : 'Enter Phone Number',
                fieldTitle: 'Phone Number (Optional)',
                controller: phoneNumberController,
                borderRadius: BorderRadius.circular(10),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              UpdateRestaurantFormField(
                hintText: websiteController.text.isNotEmpty ? websiteController.text : 'Enter Website',
                fieldTitle: 'Website (Optional)',
                controller: websiteController,
                borderRadius: BorderRadius.circular(10),
                keyboardType: TextInputType.url,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
